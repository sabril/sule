ActiveAdmin.register Server do
  menu :parent => "Settings"
  index :as => :block do |server|
    div :for => server do
      h3 link_to(server.host_name, admin_server_path(server))
      div do
        "(#{server.ip_address})"
      end
      div do
        simple_format server.description
      end
    end
    hr
    # column :host_name
    # column :ip_address
    # column :description
    # default_actions
  end
  
  filter :host_name
  filter :ip_address
  filter :description
end
