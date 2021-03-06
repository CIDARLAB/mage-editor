package org.jbei.components.pieClasses
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import org.jbei.bio.sequence.common.StrandType;
	import org.jbei.bio.sequence.dna.Feature;
	import org.jbei.components.common.AnnotationRenderer;
	import org.jbei.components.common.GraphicUtils;

    /**
     * @author Zinovii Dmytriv
     */
	public class FeatureRenderer extends AnnotationRenderer
	{
		private const DEFAULT_FEATURE_HEIGHT:int = 10;
		private const DEFAULT_FEATURES_GAP:int = 5;
		private const FRAME_COLOR:int = 0x606060;
		
		private var _middlePoint:Point;
		
		private var angle1:Number;
		private var angle2:Number;
		private var featureRadius:Number;
		
		private var alignmentRowIndex:int;
		private var railRadius:Number;
		private var center:Point;
		
		// Contructor
		public function FeatureRenderer(contentHolder:ContentHolder, feature:Feature)
		{
			super(contentHolder, feature);
		}
		
		// Properties
		public function get middlePoint():Point
		{
			return _middlePoint;
		}
		
		public function get feature():Feature
		{
			return annotation as Feature;
		}
		
		// Public Methods
		public function update(railRadius:Number, center:Point, alignmentRowIndex:int):void
		{
			this.alignmentRowIndex = alignmentRowIndex;
			this.railRadius = railRadius;
			this.center = center;
			
			featureRadius = railRadius - DEFAULT_FEATURES_GAP - 2*DEFAULT_FEATURES_GAP;
			if(alignmentRowIndex > 0) {
				featureRadius -= alignmentRowIndex * (DEFAULT_FEATURE_HEIGHT + DEFAULT_FEATURES_GAP);
			}
			
			angle1 = feature.start * 2 * Math.PI / contentHolder.sequenceProvider.sequence.length;
			angle2 = (feature.end) * 2 * Math.PI / contentHolder.sequenceProvider.sequence.length;
			
			var centralAngle:Number;
			
			if(angle1 > angle2) {
				var virtualCenter:Number = angle2 - (((2 * Math.PI - angle1) + angle2) / 2);
				
				centralAngle = (virtualCenter > 0) ? virtualCenter : (2 * Math.PI + virtualCenter);
			} else {
				centralAngle = (angle1 + angle2) / 2;
			}
			
			_middlePoint = GraphicUtils.pointOnCircle(center, centralAngle, featureRadius);
			
			needsMeasurement = true;
			invalidateDisplayList();
		}
		
		// Protected Methods
		protected override function render():void
		{
			var color:int = colorByType(feature.type.toLowerCase());
			
			var g:Graphics = graphics;
			g.clear();
			g.lineStyle(1, FRAME_COLOR);
			g.beginFill(color);
			
			var direction:uint = 0;
			if(feature.strand == StrandType.FORWARD) {
				direction = 1;
			} else if(feature.strand == StrandType.BACKWARD) {
				direction = 2;
			} else {
				direction = 0;
			}
			
			GraphicUtils.drawDirectedPiePiece(g, center, featureRadius, DEFAULT_FEATURE_HEIGHT, angle1, angle2, direction);
			
			g.endFill();
		}
		
		protected override function createToolTipLabel():void
		{
			tooltipLabel = feature.type + (feature.name == "" ? "" : (" - " + feature.name)) + ": " + (feature.start + 1) + ".." + (feature.end);
		}
		
		// Private Methods
		private function colorByType(featureType:String):int
		{
			var color:int = 0xCCCCCC;
			
			if(featureType == "insertion"){
				color = 0x4DDE00;
			} else if(featureType == "deletion"){
				color = 0xF51600;
			} else if(featureType == "mismatch"){
				color = 0xEF6500;
			} else if(featureType == "optmage"){
				color = 0xCB0077;
			} else if(featureType == "merlin"){
				color = 0x006FEF;
			}
			
			
			return color;
		}
	}
}
