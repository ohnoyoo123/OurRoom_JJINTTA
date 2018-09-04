/**
 * http://usejsdoc.org/
 */
$(document).ready(function () {		

    $('#memberSearch').on('keyup',function () {
      var searchMembers = []
      $.ajax({
        url:'../project/memberSearch',
        data: {
          mId: $('#memberSearch').val()
        },
        type: "post",

        success: function (data) {         
        
          console.log(data);
          
	      if (data.length == 0) {
	    		$('#searchedMember').html("검색된 회원이 없습니다.");
	    		return;
		  }
	      
          for(var i=0; i<data.length; i++){
        	  if ('${loginUser.mId}' != data[i].mId) {
            //members.push("<p class='member' mId="+data[i].mId+" mNickname="+data[i].mNickname+">"+data[i].mNickname+"</p>")
            searchMembers.push("<p class='member' mNickname="+data[i].mNickname+" mId="+data[i].mId+">"+data[i].mNickname+
            "("+data[i].mId+")</p>")  
        	  }
          }
          $('#searchedMember').html(searchMembers)
        }
      })
    })
    
    
        var invitedId=[]
        var invitedNickname=[]
    
    $(document).on('click', '.member', function () {
        var mNickname = $(this).attr('mNickname')
        var mId = $(this).attr('mId')
        if(!invitedId.includes(mId)){
          invitedId.push(mId)
          invitedNickname.push(mNickname)
        }

        var temp=''
        for(var i=0; i<invitedId.length; i++){
          temp+=invitedNickname[i]
          temp+='('
          temp+=invitedId[i]
          temp+=')'
          temp+='<br/>'
        }
        $('#projectMember').val(invitedId)
        $('#invitedMember').html(temp)

    })

		$('#newProject').on('click', function () {
			$.ajax({
				url : "newProject",
				data : {
					pName : $('#pName').val(),
					owner : 'hong123@gmail.com', 
					members : invitedId
				},
				type : "post",
				success : function (data) {
					location.href='gantt?pNum=' + data
				}
		})
	})
})
