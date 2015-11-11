$(document).ready(function() {
  $('button.ship-tmpl').click(function(){
    var data_json = JSON.parse($(this).attr("data"));
    $('form#ship-form')[0].action = "/loads/" + data_json.id + "/ship"
    var new_data_json_string = 
        "{\n" +
        "  \"date\": \"" + new Date() + "\"," +
        "  \"scale_weight\": \"" + Math.floor(Math.random() * 450 + 50) + "\"" +
        "}"
    $('input#ship-form-hidden').attr("value", new_data_json_string);
    $('div.modal-body').attr("db-data", $(this).attr("data"));
    $('div.modal-body').attr("new-data", new_data_json_string);
    $('div.modal-body').html(function(){
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
        "<li class=\"text-success\">Scale Weight: {%= o.scale_weight %}</li>" +
        "<li class=\"text-success\">Ship Date: {%= o.date %}</li>",
        JSON.parse($(this).attr("new-data"))
      );
    });
  });
});
