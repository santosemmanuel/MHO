function showSwal(type, title, text) {
  if (typeof Swal !== 'undefined') {
    const options = {
      icon: type || 'info',
      title: title || '',
      text: text || '',
      confirmButtonText: 'OK',
    };

    if (type === 'success') {
      options.position = 'top-end';
      options.timer = 2200;
      options.showConfirmButton = false;
      options.toast = true;
    }

    Swal.fire(options);
  } else {
    console[type === 'error' ? 'error' : 'log'](title, text);
  }
}

function swalSuccess(text, title) {
  showSwal('success', title || 'Success', text || 'Operation completed successfully.');
}

function swalError(text, title) {
  showSwal('error', title || 'Error', text || 'An error occurred.');
}

function swalWarning(text, title) {
  showSwal('warning', title || 'Warning', text || 'Please check the form and try again.');
}

function swalInfo(text, title) {
  showSwal('info', title || 'Info', text || 'Please note the information.');
}

function showMessage(type, message) {
  switch (type) {
    case 'success':
      swalSuccess(message);
      break;
    case 'error':
    case 'danger':
      swalError(message);
      break;
    case 'warning':
      swalWarning(message);
      break;
    default:
      swalInfo(message);
      break;
  }
}

window.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('form.needs-validation').forEach((form) => {
    form.addEventListener('submit', function (event) {
      if (!form.checkValidity()) {
        event.preventDefault();
        event.stopPropagation();
        form.classList.add('was-validated');
        swalWarning('Some required fields are missing or invalid. Please complete all required fields and try again.', 'Validation failed');
      }
    }, false);
  });
});
