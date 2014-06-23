Rake::Task['db:reset'].invoke

class SeedGenerator

  def self.seed_workshops
    3.times do |n|
      workshops = [
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

      hosts = [
        [
          {
            name: "Фридрих Ницше",
            description: "Бог умер.",
            link: "http://nikola-lenivets.com/"
          }
        ],
        [
          {
            name: "Иммануил Кант",
            description: "Деятельность есть наше определение.",
            link: "http://nikola-lenivets.com/"
          }
        ],
        [ 
          {
            name: "Альбер Камю",
            description: "Мир абсурден.",
            link: "http://nikola-lenivets.com/"
          },
          {
            name: "Жан-Поль Сартр",
            description: "Люди — это ад.",
            link: "http://nikola-lenivets.com/"
          }
        ]
      ]

      workshops.each_with_index do |workshop, index|
        workshop = Workshop.create workshop
        hosts[index].each do |host|
          Host.create host.merge({ 
            workshop: workshop
          })
        end
      end
    end
  end
end

SeedGenerator.seed_workshops