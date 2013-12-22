class Song < ActiveRecord::Base
 	acts_as_votable


	def youtube_url
		"http://www.youtube.com/watch?v=" + self.youtubeid
	end
	def shareable_url 
		# http://bit.ly/18bMgUM
		#Rails.root.join(self.id).to_s
		#http://0.0.0.0:3000/songs/<%= song.id %>
		root_url + "/songs/" + song.id
	end
	def google_url
		"http://google.com/#q=" + self.title + "%20mp3"
	end
end

