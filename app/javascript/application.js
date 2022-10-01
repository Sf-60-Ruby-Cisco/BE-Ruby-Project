// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"
import "chartkick"
import "Chart.bundle"



// Showing and hiding edit forms in admin panel 
document.addEventListener("turbo:load", function() {
  $('#button').click(function () {
      if ($('.adminf').is(':hidden')) {
          $('.adminf').show();
          $('#button').text('Hide edit forms').button("refresh");
      } else {
          $('.adminf').hide();
          $('#button').text('Show edit forms').button("refresh");
      }
    }); 
  });
  

 