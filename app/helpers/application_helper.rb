module ApplicationHelper
  def angular_form_tag(title, model, tag='input')
    content_tag('div', class: 'form-group') do
      content_tag('label', title, for: model, class: 'form-element') +
      content_tag(tag, "", "ng-model" => model, id: model, class: 'form-control')
    end
  end
end
