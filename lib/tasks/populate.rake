require 'nokogiri'
require 'open-uri'

# here is our api code
namespace :populate do
  desc "Fetch and store newest song titles"
  task :fetch_rapradar_songs => :environment do
  	# http://rapradar.com/category/songs/feed/
  	url = 'http://rapradar.com/category/songs/feed/'
  	doc = Nokogiri::HTML(open(url))



	doc.xpath('//item').map do |i|
      
      blog_post = {'title' => i.xpath('title').inner_text, 'link' => i.xpath('link').inner_text, 'description' => i.xpath('description').inner_text}

      #get song title without 'new music'
      song_title = blog_post['title'].gsub("New Music: ", "")
      puts song_title

	  #https://gdata.youtube.com/feeds/api/videos?q=football+-soccer

	  youtube_url = 'https://gdata.youtube.com/feeds/api/videos?q=' + URI::encode(song_title)
  	  noko_youtube = Nokogiri::HTML(open(youtube_url))


	  noko_youtube.xpath('//entry').map do |v|
		video_post = {'title' => v.xpath('title').inner_text, 'id' => v.xpath('id').inner_text}
		
		#if video_post['title'].include?(song_title)
		  

	      youtube_id_long = video_post['id']
	      youtube_id = video_post['id'].split('/').last

	      puts youtube_id_long 
	      puts youtube_id

	      break
	    #end
	  end
    end


  end
end