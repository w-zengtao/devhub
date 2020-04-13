module Api
  class ItemsController < BaseController

    def show
      load_item
      async_increment_clicked
    end

    private

    def load_item
      @item = Item.find_by(id: params[:id])
    end

    def async_increment_clicked
      # Something to do
      @item.clicked.increment
    end
  end
end
