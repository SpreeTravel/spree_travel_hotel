module Spree
  module Admin
    class RateHotelsController < ResourceController

      before_filter :load_product

      def load_product
        @product = Spree::Product.find_by_permalink(params[:permalink])
      end

      def new
        permalink = params[:permalink]
        product = Spree::Product.find_by_permalink(permalink)
        invoke_callbacks(:new_action, :before)
        invoke_callbacks(:create, :before)
        @object.attributes = {:product_id => product.id}
        if @object.save
          invoke_callbacks(:create, :after)
          flash[:success] = flash_message_for(@object, :successfully_created)
          respond_with(@object) do |format|
            format.html { redirect_to rates_path(permalink) }
            format.js   { render :layout => false }
          end
        else
          invoke_callbacks(:create, :fails)
          respond_with(@object) do |format|
            format.html { redirect_to rates_path(permalink) }
          end
        end
      end

      def update
        permalink = params[:permalink]
        product = Spree::Product.find_by_permalink(permalink)
        begin
          product.rates.each do |rate|
            rate.room_id      = params["room_#{rate.id}"]
            rate.init_date    = params["init_date_#{rate.id}"]
            rate.end_date     = params["end_date_#{rate.id}"]
            rate.plan_id      = params["plan_#{rate.id}"]
            rate.adults_one   = params["adults_one_#{rate.id}"]
            rate.adults_two   = params["adults_two_#{rate.id}"]
            rate.adults_three = params["adults_three_#{rate.id}"]
            rate.children_one = params["children_one_#{rate.id}"]
            rate.children_two = params["children_two_#{rate.id}"]
            rate.adults_extra = params["adults_extra_#{rate.id}"]
            rate.save
          end
        #  flash[:success] = "Rate for '#{product.name}' updated successfully"
        #rescue
        #  flash[:error] = "Something went wrong while updating rate"
        end
        redirect_to rates_path(permalink)
      end

      def destroy
        permalink = @object.product.permalink
        invoke_callbacks(:destroy, :before)
        if @object.destroy
          invoke_callbacks(:destroy, :after)
          flash[:success] = flash_message_for(@object, :successfully_removed)
          respond_with(@object) do |format|
            format.html { redirect_to rates_path(permalink) }
            format.js   { render :partial => "spree/admin/shared/destroy" }
          end
        else
          invoke_callbacks(:destroy, :fails)
          respond_with(@object) do |format|
            format.html { redirect_to rates_path(permalink) }
          end
        end
      end

    end
  end
end
