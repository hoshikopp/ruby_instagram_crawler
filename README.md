# InstagramCrawler

instagram_crawler is useful gem for searching instagram images information by hashtag !!!!
It is compatible for Japanese and English and etc ...

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'instagram_crawler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install instagram_crawler

## Usage (How to Use)
Very Easy !

## Make Client Object

If you want to search #hashtag pictures, 

```ruby
client = InstagramCrawler::Client.new(hashtag)
client.get_image_urls()
```

then
```ruby
[{:id=>1768954407183024563,
 :text=>
  "Follow @mem3deal3r for the spice <U+1F525> •\n•\n•\n\nTurn post notifications on <U+1F44D>\n•\n•\n•\n#memes #memez #memesdaily #memelord #dankmemes #dankest #dankmemez #dankmemezdaily #funnymemes #memes4days #memes4you #hashtag #follow #followforfollow #likes #tagsforlikes #tagsomeone #followme #instagood #instadaily #instapic  #memebox #memebase #memevideos #mememachine #memes<U+1F602> #spicymeme #meme #lmao #<U+1F602>",
 :shortcode=>"BiMlqk4AYGz",
 :dimensions=>{"height"=>612, "width"=>612},
 :image_url=>
  "https://scontent-nrt1-1.cdninstagram.com/vp/a3c6e2f0b6d63ea0d6e240daeac619f3/5AEA425E/t51.2885-15/e15/31028432_2017665511821396_6965280336599056384_n.jpg",
 :owner=>{"id"=>"7272429255"},
 :thumbnail_url=>
  "https://scontent-nrt1-1.cdninstagram.com/vp/a3c6e2f0b6d63ea0d6e240daeac619f3/5AEA425E/t51.2885-15/e15/31028432_2017665511821396_6965280336599056384_n.jpg",
 :hashtag=>
  ["#memes",
   "#memez",
   "#memebox",
   "#meme",
   "#lmao",
   "#<U+1F602>"],
 :thumnail_images=>
  [{"src"=>
     "https://scontent-nrt1-1.cdninstagram.com/vp/375e42c2736c416f19528ee96dd0873a/5AE95689/t51.2885-15/s150x150/e15/31028432_2017665511821396_6965280336599056384_n.jpg",
    "config_width"=>150,
    "config_height"=>150},
   {"src"=>
     "https://scontent-nrt1-1.cdninstagram.com/vp/5e84ba22a05373144a74d943c9312c67/5AE97E1D/t51.2885-15/s240x240/e15/31028432_2017665511821396_6965280336599056384_n.jpg",
    "config_width"=>240,
    "config_height"=>240},
   {"src"=>
     "https://scontent-nrt1-1.cdninstagram.com/vp/c0fe84ee5935b3ebbf5f4c9c8809e47d/5AE9A979/t51.2885-15/s320x320/e15/31028432_2017665511821396_6965280336599056384_n.jpg",
    "config_width"=>320,
    "config_height"=>320},
   {"src"=>
     "https://scontent-nrt1-1.cdninstagram.com/vp/bf3ce12592cde19c75891ad2bab0b6f6/5AE938A1/t51.2885-15/s480x480/e15/31028432_2017665511821396_6965280336599056384_n.jpg",
    "config_width"=>480,
    "config_height"=>480},
   {"src"=>
     "https://scontent-nrt1-1.cdninstagram.com/vp/a3c6e2f0b6d63ea0d6e240daeac619f3/5AEA425E/t51.2885-15/e15/31028432_2017665511821396_6965280336599056384_n.jpg",
    "config_width"=>640,
    "config_height"=>640}]}, ...]
```

if you want to limit the number of pictures, for example 10 pictures,
```ruby
client = InstagramCrawler::Client.new(hashtag)
client.get_image_urls(10)
```

very Easy!


## Contributing
Welcome your contributing for adding more and more abilities

Bug reports and pull requests are welcome on GitHub at https://github.com/hoshikopp/ruby_instagram_crawler .


This gem is mainly developed by [plus Quality team](https://www.plusq.life/)
