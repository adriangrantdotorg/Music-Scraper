require 'nokogiri'
require 'open-uri'

# RapRadar
namespace :populate do
  desc "RapRadar - Fetch and store newest song titles"
  task :fetch_rr_songs => :environment do
  	url = 'http://rapradar.com/category/songs/feed/'
  	doc = Nokogiri::HTML(open(url))
  	source_domain = "rapradar"

  	 doc.xpath('//item').map do |item|
          get_and_save_song(item, source_domain)
        end
  end
end

# Hypetrak
namespace :populate do
  desc "Hypetrak - Fetch and store newest song titles"
  task :fetch_ht_songs => :environment do
    url = 'http://hypetrak.com/category/music/feed/'
    doc = Nokogiri::HTML(open(url))
    source_domain = "hypetrak"

      doc.xpath('//item').map do |item|
        get_and_save_song(item, source_domain)
              
      end
  end
end
# InFlexWeTrust
namespace :populate do
  desc "InFlexWeTrust - Fetch and store newest song titles"
  task :fetch_flex_songs => :environment do
    url = 'http://www.inflexwetrust.com/category/new-music/feed/'
    doc = Nokogiri::HTML(open(url))
    source_domain = "inflexwetrust"

        doc.xpath('//item').map do |item|     
          get_and_save_song(item, source_domain)
                
      end
  end
end
# Rap Dose
namespace :populate do
  desc "Rap Dose - Fetch and store newest song titles"
  task :fetch_rd_songs => :environment do
    url = 'http://rapdose.com/category/music/feed'
    doc = Nokogiri::HTML(open(url))
    source_domain = "rapdose"

      doc.xpath('//item').map do |item|     
          get_and_save_song(item, source_domain)
              
      end
  end
end
# Nah Right
namespace :populate do
  desc "Nah Right - Fetch and store newest song titles"
  task :fetch_nr_songs => :environment do
    url = 'http://nahright.com/news/category/music/feed/'
    doc = Nokogiri::HTML(open(url))
    source_domain = "nahright"

      doc.xpath('//item').map do |item|     
          get_and_save_song(item, source_domain)
              
      end
  end
end
# XXL
namespace :populate do
  desc "XXL - Fetch and store newest song titles"
  task :fetch_xxl_songs => :environment do
    url = 'http://www.xxlmag.com/tag/bangers/feed/'
    doc = Nokogiri::HTML(open(url))
    source_domain = "xxl"

      doc.xpath('//item').map do |item|     
          get_and_save_song(item, source_domain)
              
      end
  end
end

# Allhiphop
namespace :populate do
  desc "Allhiphop - Fetch and store newest song titles"
  task :fetch_ahh_songs => :environment do
    url = 'http://allhiphop.com/category/music/feed/'
    doc = Nokogiri::HTML(open(url))
    source_domain = "allhiphop"

      doc.xpath('//item').map do |item|     
          get_and_save_song(item, source_domain)
              
      end
  end
end
# Pitchfork
namespace :populate do
  desc "Pitchfork - Fetch and store newest song titles"
  task :fetch_pf_songs => :environment do
    url = 'http://pitchfork.com/rss/reviews/best/tracks/'
    doc = Nokogiri::HTML(open(url))
    source_domain = "pitchfork"

      doc.xpath('//item').map do |item|     
          get_and_save_song(item, source_domain)
              
      end
  end
end



def get_and_save_song(item, source_domain = "")

  blog_post = {'title' => item.xpath('title').inner_text, 'link' => item.xpath('guid').inner_text}
  blog_link = blog_post['link']
  
  #MODIFY song titles to remove characters
  matchers = {'#HeaterOfTheDay: ' => '', '#FreshHeat: ' => '', 'Mixtape Download: ' => '', 'New Music: ' => '', '#DJFunkFlexApp Mixtape: ' => '', '#DJFunkFlexApp New Music: ' => '', '#DJFunkFlexApp IFWT EXCLUSIVE: ' => ''} 
  song_title = blog_post['title'].gsub(/#HeaterOfTheDay: |#FreshHeat: |Mixtape Download: |New Music: |#DJFunkFlexApp Mixtape: |#DJFunkFlexApp New Music: |#DJFunkFlexApp IFWT EXCLUSIVE: /) { |match| matchers[match] }    
# puts @source_domain
# end

  #de-duplicating inside block http://bit.ly/1giK5Hc
  catch(:stop) do
    throw :stop if Song.find_by_title(song_title)
  end

  #Grab Youtube info
  youtube_url = 'https://gdata.youtube.com/feeds/api/videos?q=' + URI::encode(song_title)
  noko_youtube = Nokogiri::HTML(open(youtube_url))

  noko_youtube.xpath('//entry').map do |v|
    video_post = {'title' => v.xpath('title').inner_text, 'id' => v.xpath('id').inner_text}

    @youtube_id_long = video_post['id']
    @youtube_id = video_post['id'].split('/').last
      break
  end

  #Save to database
  Song.create(:source => source_domain, :bloglink  => blog_link, :title => song_title, :youtubeid => @youtube_id)
  
end
