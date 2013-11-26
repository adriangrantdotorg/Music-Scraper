class Song < ActiveRecord::Base

	def youtube_url
		"http://www.youtube.com/watch?v=" + self.youtubeid
	end
end

