    jQuery ->  
      $("#check_all").click(->  
        $("input:checkbox").prop("checked", $(this).prop("checked"))  
      )  
      
      $('#selected').submit(->  
        $("input:checkbox", "table").each( ->  
          $(this).clone().css("display", 'none').appendTo("#selected")  
        )  
      )  