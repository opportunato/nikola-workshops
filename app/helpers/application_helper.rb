module ApplicationHelper
  def angular_form_tag(title, model, tag='input')
    content_tag('div', class: 'panel-body') do
      content_tag('div', title, class: 'form-element') +
      content_tag(tag, "", "ng-model" => model)
    end
  end
end
