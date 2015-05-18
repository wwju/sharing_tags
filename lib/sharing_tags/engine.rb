module SharingTags
  class Engine < ::Rails::Engine
    isolate_namespace SharingTags

    if Rails.env.development?
      config.to_prepare do
        require_dependency Rails.root.join('config', 'initializers', 'sharing_tags.rb').to_s
      end

      config.after_initialize do
        # optional, without it will call `to_prepend` only when a file changes,
        # not on every request
        Rails.application.config.reload_classes_only_on_change = false
      end
    end
  end
end