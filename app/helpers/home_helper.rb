module HomeHelper
  def add_url_markup(text)
    urls = []
    users =[]
    text.split.each{|a| a=~/(http\:\/\/\S+)/; urls << $1}
    text.split.each{|a| a=~/(\@\S+)/; users << $1}
    users.compact.each{|user| text.gsub!(user, "<a href='http://twitter.com/#{user.gsub('@','')}' target='_new'>#{user}</a>")}
    urls.compact.each{|url| text.gsub!(url, "<a href='#{url}' target='_new'>#{url}</a>")}
    text
  end
end
