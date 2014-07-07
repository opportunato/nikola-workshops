Rake::Task['db:reset'].invoke
FileUtils.rm_rf(Dir.glob(Rails.root.join "public/uploads/*"))

class SeedGenerator

  def self.image(image_name)
    File.open Rails.root.join("db/fixtures/#{image_name}"), 'r'
  end

  def self.workshops(n)
    [
      {
        title: "Преодоление человека",
        headline: "Человек — это то, что нужно преодолеть. Работаем по оригинальной авторской методике.",
        description: "",
        program: "",
        price: 5000,
        buy_link: "http://nikola-lenivets.com/",
        start_date: Date.new(2014, 9, 1 + n * 10),
        end_date: Date.new(2014, 9, 3 + n * 10),
        is_published: true
      },
      {
        title: "Взращение воли",
        headline: "Воспитываем в себе волю по популярному немецкому методу.",
        description: "",
        program: "",
        price: 3000,
        buy_link: "http://nikola-lenivets.com/",
        start_date: Date.new(2014, 9, 4 + n * 10),
        end_date: Date.new(2014, 9, 6 + n * 10),
        is_published: true
      },
      {
        title: "Воркшоп «Увлекательный экзистенциализм»",
        headline: "Ищем смысл жизни, убеждаемся в его отсутствии, создаем его сами — все за три дня!",
        description: "",
        program: "",
        price: 7000,
        buy_link: "http://nikola-lenivets.com/",
        start_date: Date.new(2014, 9, 7 + n * 10),
        end_date: Date.new(2014, 9, 10 + n * 10),
        is_published: true
      }
    ]
  end

  def self.hosts
    [
      [
        {
          name: "Фридрих Ницше",
          description: "Бог умер.",
          link: "http://nikola-lenivets.com/",
          image: image('nietzsche.jpg')
        }
      ],
      [
        {
          name: "Иммануил Кант",
          description: "Деятельность есть наше определение.",
          link: "http://nikola-lenivets.com/",
          image: image('kant.jpg')
        }
      ],
      [ 
        {
          name: "Альбер Камю",
          description: "Мир абсурден.",
          link: "http://nikola-lenivets.com/",
          image: image('camus.jpg')
        },
        {
          name: "Жан-Поль Сартр",
          description: "Люди — это ад.",
          link: "http://nikola-lenivets.com/",
          image: image('sartre.jpg')
        }
      ]
    ]
  end

  def self.videos
    [
      [
        {
          link: 'http://vimeo.com/79298045'
        }
      ],
      [
        {
          link: 'http://vimeo.com/98972251'
        },
        {
          link: 'http://vimeo.com/79286972'
        }
      ],
      [
        {
          link: 'http://vimeo.com/78821143'
        }
      ]
    ]
  end

  def self.images
    [
      {
        image: image("image-1.jpg")
      },
      {
        image: image("image-2.jpg")
      },
      {
        image: image("image-3.jpg")
      }
    ]
  end

  def self.seed_workshops
    3.times do |n|
      workshops(n).each_with_index do |workshop, index|
        workshop = Workshop.create workshop

        hosts[index].each do |host_data|
          host = Host.create host_data.merge({ 
            workshop: workshop
          }).except(:image)

          HostImage.create({
            image: host_data[:image],
            host: host
          })
        end

        videos[index].each do |workshop_video|
          WorkshopVideo.create workshop_video.merge({ 
            workshop: workshop
          })
        end

        images.each do |workshop_image|
          WorkshopImage.create workshop_image.merge({ 
            workshop: workshop
          })
        end
      end
    end
  end
end

SeedGenerator.seed_workshops