var Gello = Gello || {};

Gello.Wall = function(targetId){
	this.targetId = targetId;
	this.initialize();
}

Gello.Wall.prototype = {
	initialize: function(){
		this.target = $(this.targetId);
		this.makeCardsDraggable();
		this.makeLanesDroppable();
	},
	
	makeLanesDroppable: function(){
		$('#'+this.targetId+' .lane').droppable({
			activeClass: "ui-state-hover",
			hoverClass: "ui-state-active",
			drop: function( event, ui ) {
				var card = $(event.toElement).closest('.card');				
				$(card).appendTo($('.card-holder', this));				
			}
		});
			
	},
	
	makeCardsDraggable: function(){
		$('#'+this.targetId+' .card').draggable({
			stop: function(event, ui){
				$(this).removeAttr('style');
			}
		});
	}
}