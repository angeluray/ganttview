document.addEventListener("DOMContentLoaded", function () {
  const fileInput = document.getElementById("project_mpp_file");

  if(fileInput) {
    const submitButton = document.getElementById("submit-button");
    
    submitButton.addEventListener("click", function (e) {
        if (fileInput.files.length === 0) {
          e.preventDefault();
          alert("Please select a file to upload.");
        }
     });
  }
});