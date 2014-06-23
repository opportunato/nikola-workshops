class WorkshopsController < ApplicationController

  def index
    @workshops = Workshop.for_admin

    render layout: false
  end

  def create
    @workshop = Workshop.new(workshop_params)

    if @workshop.save && update_hosts(@workshop, workshop_params[:hosts])
      render json: @workshop, status: :created
    else
      render json: @workshop.errors, status: :unprocessable_entity
    end
  end

  def update
    @workshop = Workshop.find(params[:id])

    if @workshop.update(workshop_params) && update_hosts(@workshop, params[:workshop][:hosts])
      render json: @workshop, status: :created
    else
      render json: @workshop.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @workshop = Workshop.find(params[:id])
    @workshop.destroy

    head :no_content
  end

private
  def workshop_params
    params.require(:workshop).permit(:title, :headline, :description, :program, :price, :buy_link, :start_date, :end_date, :is_published)
  end

  # TODO oh, the humanity...

  def update_hosts(workshop, hosts)
    old_hosts = workshop.hosts
    old_hosts_ids = old_hosts.map(&:id)
    new_hosts_ids = hosts.map { |host| host[:id] }

    old_hosts.each do |host|
      if !new_hosts_ids.include?(host.id)
        host.destroy
      end
    end

    hosts.each do |host|
      if !old_hosts_ids.include?(host[:id])
        workshop.hosts.push Host.new({
          name: host[:name],
          description: host[:description],
          link: host[:link]
        })
      end
    end

    workshop.save
  end
end