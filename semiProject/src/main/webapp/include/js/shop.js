/**
 * 
 */
//나이트, 데이모드
var links = {
		setColor: function(color){
			$('a').css('color',color);
		}
}
var body = {
	    setColor: function (color) {
	        $('body').css('color', color);
	    },
	    setBackgroundColor: function (color) {
	        $('body').css('backgroundColor', color);
	    }
}
var header = {
	    setColor: function (color) {
	        $('header').css('color', color);
	    },
	    setBackgroundColor: function (color) {
	        $('header').css('backgroundColor', color);
	    }		
}
var footer = {
	    setColor: function (color) {
	        $('footer').css('color', color);
	    },
	    setBackgroundColor: function (color) {
	        $('footer').css('backgroundColor', color);
	    }		
}

function nightDayHandler(self) {
	if(self.value === 'Night') {
    	body.setBackgroundColor('black');
    	body.setColor('#ffffff');
    	header.setBackgroundColor('black');
    	header.setColor('#ffffff');
    	footer.setBackgroundColor('black');
    	footer.setColor('#ffffff');
        self.value = 'Day';
        
        links.setColor('#ffffff')
	} else {
    	body.setBackgroundColor('#ffffff');
    	body.setColor('#4D4D4D');
    	header.setBackgroundColor('#f6f5ef');
    	header.setColor('#4D4D4D');
    	footer.setBackgroundColor('#f6f5ef');
    	footer.setColor('#4D4D4D');
        self.value = 'Night';

        links.setColor('#4D4D4D')
    }
}