var Gello = Gello || {};

Gello.Wall = function(targetId){
	this.targetId = targetId;
	this.initialize();
}

Gello.Classes = {
	Unsorted: 'unsorted',
	ReadyForDev: 'ready-for-dev',
	InProgress: 'in-progress',
	Complete: 'complete'
}

Gello.Constants = {
	Unsorted: 'unsorted',
	ReadyForDev: 'ready_for_dev',
	InProgress: 'in_progress',
	Complete: 'complete'
}

Gello.Wall.prototype = {
	initialize: function(){
		this.target = $(this.targetId);
		this.makeCardsDraggable();
		this.makeLanesDroppable();
	},
	
	makeLanesDroppable: function(){
		var self = this;
		$('#'+this.targetId+' .lane').droppable({
			activeClass: "ui-state-hover",
			hoverClass: "ui-state-active",
			drop: function( event, ui ) {
				var card = $(event.toElement).closest('.card');								
				var targetLaneElement = $(this);
				var cardId = card.attr('id');
				var targetLane = '';
				
				card.draggable("destroy");
				card.remove();
				card.removeAttr('style');
				card.appendTo($('.card-holder', targetLaneElement));
				card.draggable();
								
				if(targetLaneElement.hasClass(Gello.Classes.Unsorted)) { targetLane = Gello.Constants.Unsorted };
				if(targetLaneElement.hasClass(Gello.Classes.ReadyForDev)) { targetLane = Gello.Constants.ReadyForDev };
				if(targetLaneElement.hasClass(Gello.Classes.InProgress)) { targetLane = Gello.Constants.InProgress };
				if(targetLaneElement.hasClass(Gello.Classes.Complete)) { targetLane = Gello.Constants.Complete };
				console.log(cardId);
				console.log(targetLaneElement);
				console.log(targetLane);
			}
		});
			
	},
	
	makeCardsDraggable: function(){
		$('#'+this.targetId+' .card').draggable();
	}
}