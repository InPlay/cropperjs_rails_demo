import Cropper from 'cropperjs';

const input = document.querySelector('.cropper-field');
const preview = document.querySelector('.cropper-container');

input.addEventListener('change', updateImageDisplay);

function updateImageDisplay() {
  while(preview.firstChild) {
    preview.removeChild(preview.firstChild);
  }

  const curFiles = input.files;

  if (curFiles.length === 0) {
    const para = document.createElement('p');
    para.textContent = 'No files currently selected for upload';
    preview.appendChild(para);
  } else {

    for (const file of curFiles) {
			const image = document.createElement('img');
			image.src = URL.createObjectURL(file);

      const cropper = new Cropper(image, {
        container: '.cropper-container',
        template: template(300, 200)
      });

      const cropperImage  = cropper.getCropperImage();
      const cropperCanvas = cropper.getCropperCanvas();
      const x             = document.getElementById("product_image_cropable_attributes_x");
      const y             = document.getElementById("product_image_cropable_attributes_y");
      const scale         = document.getElementById("product_image_cropable_attributes_scale");
      const bgColor       = document.getElementById("product_image_cropable_attributes_background_color");

      cropperCanvas.style.backgroundColor = bgColor.value;

      cropperImage.addEventListener('transform', (event) => {
        const matrix = event.detail.matrix;

        x.value     = matrix[4];
        y.value     = matrix[5];
        scale.value = matrix[0];
      })

      bgColor.addEventListener("change", (event) => {
        event.preventDefault();

        cropperCanvas.style.backgroundColor = event.target.value;
      })

      document.getElementById("center").addEventListener("click", (event) => {
        event.preventDefault();

        cropperImage.$center('cover')
      })

      document.getElementById("fill").addEventListener("click", (event) => {
        event.preventDefault();

        cropperImage.$center('contain')
      })
    }
  }
}

function template(width, height) {
  return `
<cropper-canvas style="height: ${height}px; width: ${width}px;">
  <cropper-image slottable></cropper-image>
  <cropper-handle action="move" plain></cropper-handle>
</cropper-canvas>
  `
}
