module TweetsHelper
    def render_with_hashtags(content)
        content.gsub(/#\w+/) { |w| link_to w, "/tweets/hashtag/#{w.downcase.delete('#')}" }.html_safe
    end
end
