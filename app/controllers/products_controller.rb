require "vips"

class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
    @product.image_cropable = CropperDatum.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    crop_image(product_params[:image_original].tempfile.path, @product.image_cropable)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product)
      .permit(:name, :image_original, image_cropable_attributes: [:x, :y, :scale, :background_color])
  end

  def crop_image(image_path, data)
    vim_img = Vips::Image.new_from_file(image_path)

    height = vim_img.height
    width  = vim_img.width

    x = (width  - (width  * data.scale)) / 2 + data.x
    y = (height - (height * data.scale)) / 2 + data.y

    background = data.background_color.remove("#").scan(/\w{2}/).map {|color| color.to_i(16) }
    background_embed = background.dup
    background_embed << 255 if vim_img.bands == 4

    vim_img = vim_img.resize(data.scale)
    vim_img = vim_img.embed(x, y, 300, 200, background: background_embed)

    path = Tempfile.new('croped').path + ".jpg"

    vim_img.write_to_file(path, background: background)

    @product.image.attach(io: File.open(path), filename: "croped")
  end
end
