module Spree
  module Admin
    class RateHotelsController < ResourceController

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
