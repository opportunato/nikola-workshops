class InstagramFetcher

  def initialize
    @client = Instagram.client
  end

  def fetch(min_date)
    InstagramTag.all.each do |tag|
      query = generate_media_query(:tag_recent_media, tag.name)
      
      fetch_before_date(query, min_date)
    end

    if ENV['INSTAGRAM_ACCOUNT_ID'].present?
      query = generate_media_query(:user_recent_media, ENV['INSTAGRAM_ACCOUNT_ID'])
      
      fetch_before_date(query, min_date)
    end
  end

private

  def generate_media_query(query_type, query_param)
    Proc.new { |max_id| @client.send(query_type, query_param, max_id) }
  end

  def fetch_before_date(query, min_date)
    has_old_images = true
    max_id = ''

    while has_old_images do
      media = query.call(max_id: max_id)

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

      max_id = media.pagination.next_max_id

      if max_id.nil?
        has_old_images = false
      end
    end
  end

  def create_feed_image(media)
    if !(FeedImage.exists? instagram_id: media.id)
      feed_image = FeedImage.new({
        instagram_id: media.id,
        instagram_link: media.link,
        origin_created_at: Time.at(media.created_time.to_i)
      })

      feed_image.remote_image_url = media.images.standard_resolution.url
      feed_image.save
    end
  end
end