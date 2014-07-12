module ApplicationHelper
  def angular_form_tag(title, model, tag='input')
    content_tag('div', class: 'form-group') do
      content_tag('label', title, for: model, class: 'form-element') +
      content_tag(tag, "", "ng-model" => model, id: model, class: 'form-control')
    end
  end

  def intro_image_url
    images = ['bg1.jpg', 'bg2.jpg', 'bg3.jpg', 'bg4.jpg', 'bg5.jpg']

    image_path(images.sample)
  end
end
