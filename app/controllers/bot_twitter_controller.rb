require 'twitter'
require 'dotenv'
Dotenv.load
class BotTwitterController < ApplicationController
  before_action :client
  
  def direct_message
    @usernames = []
    message = ""
    get_follower.each do |username|
      client.create_direct_message(username, message, options={})
      # puts "Message envoyé à @#{username}"
      @usernames << username
    end
  end

  def get_followers
    @followers = client.followers
  end

  def get_screen_name
    pattern = ("établissement" or "etablissement" or "école" or "université" or "étudiant" or "mpianatra" or "mianatra" or "hianatra")
    @tab_user_screen_name = []
    client.search(pattern, options = {geocode: "-18.8667338,47.5299638,1100km", result_type: "recent"}).take(50).collect do |tweet|
        @tab_user_screen_name << tweet.user.screen_name
    end
    return @tab_user_screen_name
  end

  def get_status_id
    pattern = ("établissement" or "etablissement" or "école" or "université" or "étudiant" or "mpianatra" or "mianatra" or "hianatra")
    @tab_status = []
    client.search(pattern, options = {geocode: "-18.8667338,47.5299638,1100km", result_type: "recent"}).take(50).collect do |tweet|
        @tab_status << tweet.id
    end
    return @tab_status
  end

  def send_public_tweet
      client.update_with_media("Découvrir E-anatra via son site web facebook https://www.facebook.com/events/373205243176892", File.new("./images/concours_piscine_sayna2.jpg"))
  end

  def send_private_tweet
    @tab_users = []
    @infos_users = Hash.new
    @tab_username = get_screen_name
    i = 0
    get_status_id.each do |id|
      @infos_users[id] = @tab_username[i]
        i+=1
    end
    
    # j = 0
    @infos_users.each do |id, username|
      client.update_with_media("@#{username} Nous venons d'ouvrir un site pour faciliter la recherche d'un établissement scolaire à Madagascar. Visitez E-anatra via son compte facebook https://www.facebook.com/E-anatra-178591866120655/", File.new("public/images/bot/e-anatra.png"), in_reply_to_status_id: id)
      @tab_users << username
    end
  end

  private
  
  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
  end

end