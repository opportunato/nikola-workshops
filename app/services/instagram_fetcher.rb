class InstagramFetcher

  def initialize
    @client = Instagram.client
  end

  def fetch(min_date)
    InstagramTag.all.each do |tag|
      fetch_before_date(tag.name, min_date)
    end

    if ENV['INSTAGRAM_ACCOUNT_ID'].present?
      media = @client.user_recent_media(ENV['INSTAGRAM_ACCOUNT_ID'], min_timestamp: min_date.to_time.to_i)
    
      media.each do |media|
        if media.type == "image"
          create_feed_image(media)
        end
      end
    end
  end

private 

  def fetch_before_date(tag, min_date)
    has_old_images = true
    max_id = ''

    while has_old_images do
      media = @client.tag_recent_media(tag, max_tag_id: max_id)

      media.each do |media|
        if media.type == "image"
          media_date = Time.at(media.created_time.to_i)

          if media_date > min_date
            create_feed_image(media)
          else
            has_old_images = false
            return
          end
        end
      end

      max_id = u.pagination.next_max_tag_id
    end
  end

  def create_feed_image(media)
    feed_image = FeedImage.new({
      instagram_id: media.id,
      instagram_link: media.link
    })

    feed_image.remote_image_url = media.images.standard_resolution.url
    feed_image.save
  end
end