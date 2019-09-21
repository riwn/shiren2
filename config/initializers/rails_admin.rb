RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan == 運用の時は必ずOnにすること
  config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit
  config.model Rank do
    edit do
      # 全てのフィールドを加える
      include_all_fields
      # "name" field のみ readonly を設定
      field :name do
        read_only true
      end
      field :dungeon do
        read_only true
      end
      field :result do
        read_only true
      end
      field :movie do
        read_only true
      end
      field :recordimage do
        read_only true
      end
      field :user_id do
        read_only true
      end
    end
  end

  if Rank.table_exists?
    RailsAdmin.config Rank do
      list do
        # simply adding fields by their names (order will be maintained)
        include_fields :id, :name, :dungeon, :permission, :rejection, :rejectioncomment, :created_at, :updated_at
      end
    end
  end

  if User.table_exists?
    RailsAdmin.config User do
      list do
        # simply adding fields by their names (order will be maintained)
        include_fields :name, :niconico, :youtube, :twitch, :introduction
      end
    end
  end

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
