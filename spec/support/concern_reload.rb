def concern_reload
  HighVoltage::PagesController.class_eval do
    if respond_to?(:caches_action)
      caches_action :show, if: -> { HighVoltage.action_caching }
    end

    if respond_to?(:caches_page)
      caches_page :show, if: -> { HighVoltage.page_caching }
    end
  end
end
