require "instagram_crawler/version"
require 'logger'
require 'json'
require 'net/http'

module InstagramCrawler
  class Client
    def initialize(hashtag)
      @hashtag = hashtag
      @crawler = GetHashTagUrl.new(@hashtag)
    end

    def get_image_urls(limit = 1000)
       @crawler.download_hashtag(limit)
    end
  end
end

module InstagramCrawler
  class GetHashTagUrl
    attr_accessor :images
    def initialize(hashtag)
      @logger = Logger.new(STDOUT)
      @hashtag = hashtag
      @images = []
    end

    def info(message)
      @logger.info(message)
    end

    def error(message)
      @logger.error(message)
    end

    def download_hashtag(limit)
      next_page = nil
      number = 0
      loop do
        get_number, next_page = download_hashtag_page(@hashtag, next_page)
        number += get_number
        info "getting #{number} ##{@hashtag} images...."
        break if next_page.nil? || number > limit
      end
      @images = @images.take(limit) if @images.count > limit
      return @images
    end

    def download_hashtag_page(hashtag, page)
      json_result = download_per_page(hashtag, page)
      return [0, nil] if json_result.nil?
      hashtag_info = json_result['graphql']['hashtag']
      size = 0
      %w(media top_posts).each do |part|
        next if part == 'top_posts' && page
        edges = hashtag_info["edge_hashtag_to_#{part}"]['edges']
        edges.each do |edge|
          hashtag_format = format_edge(edge)
          @images << hashtag_format
        end
        next if edges.empty?
        size += edges.size
      end
      if hashtag_info['edge_hashtag_to_media']['page_info']['has_next_page']
        [size, hashtag_info['edge_hashtag_to_media']['page_info']['end_cursor']]
      else
        [size, nil]
      end
    end

    # retuen result_hash
    def format_edge(edge)
      return if edge.nil?
      {
        id: edge["node"]["id"].to_i,
        text: edge["node"]["edge_media_to_caption"]["edges"][0]["node"]["text"],
        shortcode: edge["node"]["shortcode"],
        dimensions: edge["node"]["dimensions"],
        image_url: edge["node"]["display_url"],
        owner: edge["node"]["owner"],
        thumbnail_url: edge["node"]["thumbnail_src"],
        hashtag: edge["node"]["edge_media_to_caption"]["edges"][0]["node"]["text"].scan(%r|\s?(#[^\s　]+)\s?|).flatten,
        thumnail_images: edge["node"]["thumbnail_resources"]
      }
    rescue => e
      return nil
    end

    def download_per_page(hashtag, page, use_cookie = false)
      download_uri = hashtag_page_url(hashtag, page)
      return if download_uri.nil?
      result = http_access(download_uri, use_cookie)
      JSON.parse(result)
    rescue JSON::ParserError => e
      error "JSON parsing failed for URI: #{download_uri}, not retrying"
      return nil
    rescue => e
      error "Download failed for URI: #{download_uri} retrying ..."
      sleep 1
      retry
    end

    def http_access(uri, use_cookie = false, try = 3, first = true)
      response = if use_cookie
                   http = Net::HTTP.new(uri.hostname, uri.port)
                   http.use_ssl = true
                   http.get(uri, 'Cookie' => false)
                 else
                   Net::HTTP.get_response uri
                 end
      if response.code.to_i >= 399
        if try > 0
          warn "Downloading #{uri} ended in #{response.code} Retrying #{try} times."
          if response.code == 429
            sleep 5
            return http_access(uri, use_cookie, 10, false) if first
          else
            sleep 1
          end
          http_access(uri, use_cookie, try -1 , first)
        else
          response.body
        end
      else
        response.body
      end
    rescue => e
      if try > 0
        warn "Downlading #{uri} ended in #{e}. Retring #{try} times"
        sleep 1
        http_access(uri, use_cookie, try -1, first)
      else
        ""
      end
    end

    def hashtag_page_url(hashtag, page)
      if page
        URI.parse URI.encode "https://www.instagram.com/explore/tags/#{hashtag}/?__a=1&max_id=#{page}"
      else
        URI.parse URI.encode "https://www.instagram.com/explore/tags/#{hashtag}/?__a=1"
      end
    rescue URI::InvalidURIError
      error "Invalid hashtag #{hashtag} .."
    end
  end
end
