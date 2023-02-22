# Summary

Use [cropperjs v2](https://fengyuanchen.github.io/cropperjs/v2/guide.html), activestorage, image_processing (& vips), activejob if applicable, and an html color input to make an image cropper tool similar to most croppers. Our tool, however, needs to also capable of increasing the canvas height of the uploaded image to match predefined dimensions using a chosen fill color.

This is most likely easiest to store a background color and set it client side, but backend processing of the fill color is fine if it's more straightforward.

Use this project to add two image fields, primary_image and logo, to the
Product CRUD actions following the specifications below.

# Specifications

* Tool must be used inside of an otherwise normal form, and image will be submitted with other multipart form data.
* Support multiple instances on a single form.
* Images will not be uploaded until form is submitted.
* Any image thumbnail processing will happen using activejob, although I think the image_processing gem might handle cropping lazily, in which case this would not be applicable.
* Image fields will specify dimensions, and users will only be able to crop to those dimensions.
* Tool will default to showing the full width of the image, with no fill color. This represents no cropping.
* Users will be able to remove the image via a button, but will not delete the image until the form is submitted.

# References

Recently a youtube video was produced showing cropperjs v1 and activestorage. Since cropperjs v1 is in maintenance mode, we'd like to attempt cropperjs v2 for future-proofing.

https://www.youtube.com/watch?v=Ith6FA0kxPc
