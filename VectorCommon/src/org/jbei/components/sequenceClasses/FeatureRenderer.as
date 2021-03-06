package org.jbei.components.sequenceClasses
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import org.jbei.bio.sequence.common.StrandType;
	import org.jbei.bio.sequence.dna.Feature;
	import org.jbei.components.common.AnnotationRenderer;
	import org.jbei.components.common.IContentHolder;

    /**
     * @author Zinovii Dmytriv
     */
	public class FeatureRenderer extends AnnotationRenderer
	{
		public static const DEFAULT_FEATURE_HEIGHT:int = 6;
		public static const DEFAULT_FEATURES_SEQUENCE_GAP:int = 3;
		public static const DEFAULT_FEATURES_GAP:int = 2;
		
		private var sequenceContentHolder:ContentHolder;
		
		// Contructor
		public function FeatureRenderer(contentHolder:IContentHolder, feature:Feature)
		{
			super(contentHolder, feature);
			
			sequenceContentHolder = contentHolder as ContentHolder;
		}
		
		// Properties
		public function get feature():Feature
		{
			return annotation as Feature;
		}
		
		// Public Methods
		public function update():void
		{
			needsMeasurement = true;
			invalidateDisplayList();
		}
		
		// Protected Methods
		protected override function render():void
		{
			super.render();
			
			var g:Graphics = graphics;
			g.clear();
			
			var featureRows:Array = sequenceContentHolder.rowMapper.featureToRowMap[feature];
			
			if(! featureRows) { return; }
			
			for(var i:int = 0; i < featureRows.length; i++) {
				var row:Row = sequenceContentHolder.rowMapper.rows[featureRows[i]] as Row;
				
				// find feature row index
				var alignmentRowIndex:int = -1;
				
				for(var r:int = 0; r < row.rowData.featuresAlignment.length; r++) {
					var rowFeatures:Array = row.rowData.featuresAlignment[r] as Array;
					
					for(var c:int = 0; c < rowFeatures.length; c++) {
						if((rowFeatures[c] as Feature) == feature) {
							alignmentRowIndex = r;
							break;
						}
					}
					
					if(alignmentRowIndex != -1) { break; }
				}
				
				g.lineStyle(1, 0x606060);
				g.beginFill(colorByType(feature.type.toLowerCase()));
				
				var startBP:int;
				var endBP:int;
				
				if(feature.start > feature.end) { // circular case
					/* |--------------------------------------------------------------------------------------|
					*  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF|                                             */
					if(feature.end >= row.rowData.start && feature.end <= row.rowData.end) {
						endBP = feature.end - 1;
					}
						/* |--------------------------------------------------------------------------------------|
						*  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF  */
					else if(row.rowData.end >= contentHolder.sequenceProvider.sequence.length) {
						endBP = contentHolder.sequenceProvider.sequence.length - 1;
					}
					else {
						endBP = row.rowData.end;
					}
					
					/* |--------------------------------------------------------------------------------------|
					*                                    |FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF  */
					if(feature.start >= row.rowData.start && feature.start <= row.rowData.end) {
						startBP = feature.start;
					}
						/* |--------------------------------------------------------------------------------------|
						*   FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF  */
					else {
						startBP = row.rowData.start;
					}
				} else {
                    if (feature.start < row.rowData.start && feature.end <= row.rowData.start) {
                        continue; // the feature is outside of the current row
                    } else {
    					startBP = (feature.start < row.rowData.start) ? row.rowData.start : feature.start;
    					endBP = (feature.end - 1 < row.rowData.end) ? feature.end - 1 : row.rowData.end;
                    }
				}
				
				/* Case when start and end are in the same row
				* |--------------------------------------------------------------------------------------|
				*  FFFFFFFFFFFFFFFFFFFFFFFFFFF|                     |FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF  */
				if(startBP > endBP) {
					var bpStartMetrics1:Rectangle = sequenceContentHolder.bpMetricsByIndex(row.rowData.start);
					var bpEndMetrics1:Rectangle = sequenceContentHolder.bpMetricsByIndex(Math.min(endBP, contentHolder.sequenceProvider.sequence.length - 1));
					
					var bpStartMetrics2:Rectangle = sequenceContentHolder.bpMetricsByIndex(startBP);
					var bpEndMetrics2:Rectangle = sequenceContentHolder.bpMetricsByIndex(Math.min(row.rowData.end, contentHolder.sequenceProvider.sequence.length - 1));
					
					var featureX1:Number = bpStartMetrics1.x + 2; // +2 to look pretty
					var featureX2:Number = bpStartMetrics2.x + 2; // +2 to look pretty
					var featureYCommon:Number = bpStartMetrics1.y + row.sequenceMetrics.height + alignmentRowIndex * (DEFAULT_FEATURE_HEIGHT + DEFAULT_FEATURES_GAP) + DEFAULT_FEATURES_SEQUENCE_GAP;
					
					if(sequenceContentHolder.showAminoAcids1RevCom) {
						featureYCommon += 3 * sequenceContentHolder.aminoAcidsTextRenderer.textHeight;
					}
					
					var featureRowWidth1:Number = bpEndMetrics1.x - bpStartMetrics1.x + sequenceContentHolder.sequenceSymbolRenderer.textWidth;
					var featureRowWidth2:Number = bpEndMetrics2.x - bpStartMetrics2.x + sequenceContentHolder.sequenceSymbolRenderer.textWidth;
					
					var featureRowHeightCommon:Number = DEFAULT_FEATURE_HEIGHT;
					
					if(feature.strand == StrandType.UNKNOWN) {
						drawFeatureRect(g, featureX1, featureYCommon, featureRowWidth1, featureRowHeightCommon);
						drawFeatureRect(g, featureX2, featureYCommon, featureRowWidth2, featureRowHeightCommon);
					} else if(feature.strand == StrandType.FORWARD) {
						drawFeatureForwardArrow(g, featureX1, featureYCommon, featureRowWidth1, featureRowHeightCommon);
						drawFeatureForwardRect(g, featureX2, featureYCommon, featureRowWidth2, featureRowHeightCommon);
					} else if(feature.strand == StrandType.BACKWARD) {
						drawFeatureBackwardRect(g, featureX1, featureYCommon, featureRowWidth1, featureRowHeightCommon);
						drawFeatureBackwardArrow(g, featureX2, featureYCommon, featureRowWidth2, featureRowHeightCommon);
					}
				} else {
					var bpStartMetrics:Rectangle = sequenceContentHolder.bpMetricsByIndex(startBP);
					var bpEndMetrics:Rectangle = sequenceContentHolder.bpMetricsByIndex(Math.min(endBP, contentHolder.sequenceProvider.sequence.length - 1));
					
					var featureX:Number = bpStartMetrics.x + 2; // +2 to look pretty
					var featureY:Number = bpStartMetrics.y + row.sequenceMetrics.height + alignmentRowIndex * (DEFAULT_FEATURE_HEIGHT + DEFAULT_FEATURES_GAP) + DEFAULT_FEATURES_SEQUENCE_GAP;
					
					if(sequenceContentHolder.showAminoAcids1RevCom) {
						featureY += 3 * sequenceContentHolder.aminoAcidsTextRenderer.textHeight;
					}
					
					var featureRowWidth:Number = bpEndMetrics.x - bpStartMetrics.x + sequenceContentHolder.sequenceSymbolRenderer.textWidth;
					var featureRowHeight:Number = DEFAULT_FEATURE_HEIGHT;
					
					if(feature.strand == StrandType.UNKNOWN) {
						drawFeatureRect(g, featureX, featureY, featureRowWidth, featureRowHeight);
					} else if(feature.strand == StrandType.FORWARD) {
						if(feature.end >= row.rowData.start && feature.end <= row.rowData.end + 1) {
							drawFeatureForwardArrow(g, featureX, featureY, featureRowWidth, featureRowHeight);
						} else {
							drawFeatureForwardRect(g, featureX, featureY, featureRowWidth, featureRowHeight);
						}
					} else if(feature.strand == StrandType.BACKWARD) {
						if(feature.start >= row.rowData.start && feature.start <= row.rowData.end) {
							drawFeatureBackwardArrow(g, featureX, featureY, featureRowWidth, featureRowHeight);
						} else {
							drawFeatureBackwardRect(g, featureX, featureY, featureRowWidth, featureRowHeight);
						}
					}
				}
				
				g.endFill();
			}
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
		
		private function drawFeatureRect(g:Graphics, x:Number, y:Number, width:Number, height:Number):void
		{
			g.drawRect(x, y, width, height);
		}
		
		private function drawFeatureForwardRect(g:Graphics, x:Number, y:Number, width:Number, height:Number):void
		{
			g.moveTo(x, y);
			g.curveTo(x + 3, y + height / 2, x, y + height);
			g.lineTo(x + width, y + height);
			g.lineTo(x + width, y);
			g.lineTo(x, y);
		}
		
		private function drawFeatureBackwardRect(g:Graphics, x:Number, y:Number, width:Number, height:Number):void
		{
			g.moveTo(x, y);
			g.lineTo(x, y + height);
			g.lineTo(x + width, y + height);
			g.curveTo(x + width - 3, y + height / 2, x + width, y);
			g.lineTo(x, y);
		}
		
		private function drawFeatureForwardArrow(g:Graphics, x:Number, y:Number, width:Number, height:Number):void
		{
			if(width > sequenceContentHolder.sequenceSymbolRenderer.width) {
				g.moveTo(x, y);
				g.lineTo(x + width - 8, y);
				g.lineTo(x + width, y + height / 2);
				g.lineTo(x + width - 8, y + height);
				g.lineTo(x, y + height);
				g.curveTo(x + 3, y + height / 2, x, y);
			} else {
				g.moveTo(x, y);
				g.lineTo(x + width, y + height / 2);
				g.lineTo(x, y + height);
				g.lineTo(x, y);
			}
		}
		
		private function drawFeatureBackwardArrow(g:Graphics, x:Number, y:Number, width:Number, height:Number):void
		{
			if(width > sequenceContentHolder.sequenceSymbolRenderer.width) {
				g.moveTo(x + 8, y);
				g.lineTo(x + width, y);
				g.curveTo(x + width - 3, y + height / 2, x + width, y + height);
				g.lineTo(x + 8, y + height);
				g.lineTo(x, y + height / 2);
				g.lineTo(x + 8, y);
			} else {
				g.moveTo(x, y + height / 2);
				g.lineTo(x + width, y);
				g.lineTo(x + width, y + height);
				g.lineTo(x, y + height / 2);
			}
		}
	}
}
