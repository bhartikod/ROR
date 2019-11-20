<script>
$(function(){
  $("form").submit(function(event){
    debugger
    event.preventDefault();
    var action = $(this).attr('action');
    var fname = $(this).find('#profile_fname').val();
    var lanme = $(this).find('#profile_lname').val();
    var address = $(this).find('#profile_address').val();
    var image = $(this).find('#profile_image').val();
    $.ajax({
      type: "PATCH"
      url: action,
      data: { fname123: fname,lanme: lname,address: address,image: image }
    });   
  });
});
</script>