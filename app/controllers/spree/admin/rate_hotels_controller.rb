module Spree
  module Admin
    class RateHotelsController < ResourceController

      before_filter :load_product

      def combinations

      end

      def load_product
        @product = Spree::Product.find_by_permalink(params[:permalink])
      end

      def new_exception
        permalink = params[:permalink]
        product = Spree::Product.find_by_permalink(permalink)
        exception = Spree::ExceptionHotel.new :product_id => product.id
        if exception.save
          flash[:success] = flash_message_for(exception, :successfully_created)
          respond_with(exception) do |format|
            format.html { redirect_to hotel_rates_path(permalink) }
            format.js   { render :layout => false }
          end
        else
          respond_with(exception) do |format|
            format.html { redirect_to hotel_rates_path(permalink) }
          end
        end
      end

      def new
        permalink = params[:permalink]
        product = Spree::Product.find_by_permalink(permalink)
        @object.attributes = {:product_id => product.id}
        if @object.save
          flash[:success] = flash_message_for(@object, :successfully_created)
          respond_with(@object) do |format|
            format.html { redirect_to hotel_rates_path(permalink) }
            format.js   { render :layout => false }
          end
        else
          respond_with(@object) do |format|
            format.html { redirect_to hotel_rates_path(permalink) }
          end
        end
      end

      def update
        permalink = params[:permalink]
        product = Spree::Product.find_by_permalink(permalink)
        begin
          product.rates.each do |rate|
            rate.room_id      = params["rate_room_#{rate.id}"]
            rate.plan_id      = params["rate_plan_#{rate.id}"]
            rate.init_date    = params["rate_init_date_#{rate.id}"]
            rate.end_date     = params["rate_end_date_#{rate.id}"]
            rate.adults_one   = params["rate_adults_one_#{rate.id}"]
            rate.adults_two   = params["rate_adults_two_#{rate.id}"]
            rate.adults_three = params["rate_adults_three_#{rate.id}"]
            rate.adults_extra = params["rate_adults_extra_#{rate.id}"]
            rate.children_one = params["rate_children_one_#{rate.id}"]
            rate.children_two = params["rate_children_two_#{rate.id}"]
            rate.max_adults   = params["rate_max_adults_#{rate.id}"]
            rate.max_children = params["rate_max_children_#{rate.id}"]
            rate.save
          end
          product.exceptions.each do |exception|
            exception.room_id   = params["exception_room_#{exception.id}"]
            exception.plan_id   = params["exception_plan_#{exception.id}"]
            exception.init_date = params["exception_init_date_#{exception.id}"]
            exception.end_date  = params["exception_end_date_#{exception.id}"]
            exception.adults    = params["exception_adults_#{exception.id}"]
            exception.children  = params["exception_children_#{exception.id}"]
            exception.save
          end
          flash[:success] = "Rate for '#{product.name}' updated successfully"
        rescue
          flash[:error] = "Something went wrong while updating rate"
        end
        redirect_to hotel_rates_path(permalink)
      end

      def generate_combinations
        permalink = params[:permalink]
        product = Spree::Product.find_by_permalink(permalink)
        product.generate_combinations
        redirect_to hotel_rates_path(permalink)
      end

      def destroy
        permalink = @object.product.permalink
        invoke_callbacks(:destroy, :before)
        if @object.destroy
          invoke_callbacks(:destroy, :after)
          flash[:success] = flash_message_for(@object, :successfully_removed)
          respond_with(@object) do |format|
            format.html { redirect_to hotel_rates_path(permalink) }
            format.js   { render :partial => "spree/admin/shared/destroy" }
          end
        else
          invoke_callbacks(:destroy, :fails)
          respond_with(@object) do |format|
            format.html { redirect_to hotel_rates_path(permalink) }
          end
        end
      end

      def destroy_exception
        exception = Spree::ExceptionHotel.find(params[:id])
        permalink = params[:permalink]
        if exception.destroy
          flash[:success] = flash_message_for(exception, :successfully_removed)
          respond_with(exception) do |format|
            format.html { redirect_to hotel_rates_path(permalink) }
            format.js   { render :partial => "spree/admin/shared/destroy" }
          end
        else
          respond_with(exception) do |format|
            format.html { redirect_to hotel_rates_path(permalink) }
          end
        end
      end

    end
  end
end
