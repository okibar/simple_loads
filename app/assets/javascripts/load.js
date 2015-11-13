// Quick-Ship

(function( $ ){
  $.fn.shipUpdateBody = function(generated_data) {
    $(this).attr("new-data", generated_data);
    $(this).html(function(){
      return tmpl(
        "<li>Status: {%= o.status %}</li>" +
        "<li>Customer: {%= o.customer_name %}</li>" +
        "<li>Location: {%= o.customer_location %}</li>" +
        "<li>Carrier: {%= o.carrier_name %}</li>" +
        "<li>Driver: {%= o.driver_name %}</li>" +
        "<li>Order: {%= o.order_number %}</li>" +
        "<li>Origin: {%= o.origin_location %}</li>" +
        "<li>Product: {%= o.product_description %}</li>" +
        "<li>Requested Date: {%= o.requested_date %}</li>",
        JSON.parse($(this).attr("db-data"))
      ) + tmpl(
        "<li class=\"text-success\">Scale Weight: {%= o.weight_gross %}</li>" +
        "<li class=\"text-success\">Ship Date: {%= o.ship_date %}</li>",
        JSON.parse($(this).attr("new-data"))
      );
    });
  };
})(jQuery);
(function( $ ){
  $.fn.shipUpdate = function() {
    var scale_weight = Math.floor(Math.random() * 450 + 50);
    var generated_data =
        "{\n" +
        "  \"ship_date\": \"" + new Date() + "\"," +
        "  \"weight_gross\": \"" + scale_weight + "\"" +
        "}";
    $('input#load').attr("value", generated_data);
    $('div#modal-ship-tmpl-body').shipUpdateBody(generated_data);
    if($('div.modal')[0].style.display != "none") {
      setTimeout($('div#modal-ship-tmpl-body').shipUpdate, 300);
    }
  };
})(jQuery);
$(document).ready(function() {
  $('button.ship-tmpl').click(function(){
    var data_json = JSON.parse($(this).attr("data"));
    $('form#ship-form')[0].action = "/loads/" + data_json.id + "/ship";
    $('div.modal-body').attr("db-data", $(this).attr("data"));
    setTimeout($('div.modal-body').shipUpdate, 300);
  });
});

// Quick-Dispatch

(function( $ ){
  $.fn.dispatchUpdateBody = function(generated_data) {
    $(this).attr("new-data", generated_data);
    $(this).html(function(){
      return tmpl(
        "<li>Status: {%= o.status %}</li>" +
        "<li>Customer: {%= o.customer_name %}</li>" +
        "<li>Location: {%= o.customer_location %}</li>" +
        "<li>Order: {%= o.order_number %}</li>" +
        "<li>Origin: {%= o.origin_location %}</li>" +
        "<li>Product: {%= o.product_description %}</li>" +
        "<li>Requested Date: {%= o.requested_date %}</li>",
        JSON.parse($(this).attr("db-data"))
      ) + tmpl(
        "<li class=\"text-success\">Scale Weight: {%= o.weight_tare %}</li>",
        JSON.parse($(this).attr("new-data"))
      );
    });
  };
})(jQuery);
(function( $ ){
  $.fn.dispatchUpdate = function() {
    var scale_weight = Math.floor(Math.random() * 450 + 50);
    var generated_data =
        "{\n" +
        "  \"weight_tare\": \"" + scale_weight + "\"" +
        "}";
    $('input#entry').attr("value", generated_data);
    $('div#modal-dispatch-tmpl-body').dispatchUpdateBody(generated_data);
    if($('div.modal')[1].style.display != "none") {
      setTimeout($('div#modal-dispatch-tmpl-body').dispatchUpdate, 300);
    }
  };
})(jQuery);
$(document).ready(function() {
  $('button.dispatch-tmpl').click(function(){
    var data_json = JSON.parse($(this).attr("data"));
    $('form#dispatch-form')[0].action = "/loads/" + data_json.id + "/quickdispatch";
    $('div#modal-dispatch-tmpl-body').attr("db-data", $(this).attr("data"));
    setTimeout($('div.modal-body').dispatchUpdate, 300);
  });
});
