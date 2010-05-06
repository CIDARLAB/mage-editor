package org.jbei.registry.utils
{
	import mx.collections.ArrayCollection;
	
	import org.jbei.bio.data.RestrictionEnzyme;

	public class RestrictionEnzymesUtils
	{
		public static function commonRestrictionEnzymes():ArrayCollection /* RestrictionEnzyme */
		{
			var enzymes:ArrayCollection = new ArrayCollection();
			
			var commonRestrictionEnzymesXML:XML = <enzymes><enzyme><name>AatII</name><site>gacgtc</site><cutType>0</cutType><reverseRegex><![CDATA[gacgtc]]></reverseRegex><forwardRegex><![CDATA[gacgtc]]></forwardRegex><downstream><dsForward>5</dsForward><dsReverse>1</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>AvrII</name><site>cctagg</site><cutType>0</cutType><reverseRegex><![CDATA[c{2}tag{2}]]></reverseRegex><forwardRegex><![CDATA[c{2}tag{2}]]></forwardRegex><downstream><dsForward>1</dsForward><dsReverse>5</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>BamHI</name><site>ggatcc</site><cutType>0</cutType><reverseRegex><![CDATA[g{2}atc{2}]]></reverseRegex><forwardRegex><![CDATA[g{2}atc{2}]]></forwardRegex><downstream><dsForward>1</dsForward><dsReverse>5</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>BglII</name><site>agatct</site><cutType>0</cutType><reverseRegex><![CDATA[agatct]]></reverseRegex><forwardRegex><![CDATA[agatct]]></forwardRegex><downstream><dsForward>1</dsForward><dsReverse>5</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>BsgI</name><site>gtgcag</site><cutType>0</cutType><reverseRegex><![CDATA[ctgcac]]></reverseRegex><forwardRegex><![CDATA[gtgcag]]></forwardRegex><downstream><dsForward>22</dsForward><dsReverse>20</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>EagI</name><site>cggccg</site><cutType>0</cutType><reverseRegex><![CDATA[cg{2}c{2}g]]></reverseRegex><forwardRegex><![CDATA[cg{2}c{2}g]]></forwardRegex><downstream><dsForward>1</dsForward><dsReverse>5</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>EcoRI</name><site>gaattc</site><cutType>0</cutType><reverseRegex><![CDATA[ga{2}t{2}c]]></reverseRegex><forwardRegex><![CDATA[ga{2}t{2}c]]></forwardRegex><downstream><dsForward>1</dsForward><dsReverse>5</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>EcoRV</name><site>gatatc</site><cutType>0</cutType><reverseRegex><![CDATA[gatatc]]></reverseRegex><forwardRegex><![CDATA[gatatc]]></forwardRegex><downstream><dsForward>3</dsForward><dsReverse>3</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>HindIII</name><site>aagctt</site><cutType>0</cutType><reverseRegex><![CDATA[a{2}gct{2}]]></reverseRegex><forwardRegex><![CDATA[a{2}gct{2}]]></forwardRegex><downstream><dsForward>1</dsForward><dsReverse>5</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>KpnI</name><site>ggtacc</site><cutType>0</cutType><reverseRegex><![CDATA[g{2}tac{2}]]></reverseRegex><forwardRegex><![CDATA[g{2}tac{2}]]></forwardRegex><downstream><dsForward>5</dsForward><dsReverse>1</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>NcoI</name><site>ccatgg</site><cutType>0</cutType><reverseRegex><![CDATA[c{2}atg{2}]]></reverseRegex><forwardRegex><![CDATA[c{2}atg{2}]]></forwardRegex><downstream><dsForward>1</dsForward><dsReverse>5</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>NdeI</name><site>catatg</site><cutType>0</cutType><reverseRegex><![CDATA[catatg]]></reverseRegex><forwardRegex><![CDATA[catatg]]></forwardRegex><downstream><dsForward>2</dsForward><dsReverse>4</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>NheI</name><site>gctagc</site><cutType>0</cutType><reverseRegex><![CDATA[gctagc]]></reverseRegex><forwardRegex><![CDATA[gctagc]]></forwardRegex><downstream><dsForward>1</dsForward><dsReverse>5</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>NotI</name><site>gcggccgc</site><cutType>0</cutType><reverseRegex><![CDATA[gcg{2}c{2}gc]]></reverseRegex><forwardRegex><![CDATA[gcg{2}c{2}gc]]></forwardRegex><downstream><dsForward>2</dsForward><dsReverse>6</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>PstI</name><site>ctgcag</site><cutType>0</cutType><reverseRegex><![CDATA[ctgcag]]></reverseRegex><forwardRegex><![CDATA[ctgcag]]></forwardRegex><downstream><dsForward>5</dsForward><dsReverse>1</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>PvuI</name><site>cgatcg</site><cutType>0</cutType><reverseRegex><![CDATA[cgatcg]]></reverseRegex><forwardRegex><![CDATA[cgatcg]]></forwardRegex><downstream><dsForward>4</dsForward><dsReverse>2</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>SacI</name><site>gagctc</site><cutType>0</cutType><reverseRegex><![CDATA[gagctc]]></reverseRegex><forwardRegex><![CDATA[gagctc]]></forwardRegex><downstream><dsForward>5</dsForward><dsReverse>1</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>SacII</name><site>ccgcgg</site><cutType>0</cutType><reverseRegex><![CDATA[c{2}gcg{2}]]></reverseRegex><forwardRegex><![CDATA[c{2}gcg{2}]]></forwardRegex><downstream><dsForward>4</dsForward><dsReverse>2</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>SalI</name><site>gtcgac</site><cutType>0</cutType><reverseRegex><![CDATA[gtcgac]]></reverseRegex><forwardRegex><![CDATA[gtcgac]]></forwardRegex><downstream><dsForward>1</dsForward><dsReverse>5</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>SmaI</name><site>cccggg</site><cutType>0</cutType><reverseRegex><![CDATA[c{3}g{3}]]></reverseRegex><forwardRegex><![CDATA[c{3}g{3}]]></forwardRegex><downstream><dsForward>3</dsForward><dsReverse>3</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>SpeI</name><site>actagt</site><cutType>0</cutType><reverseRegex><![CDATA[actagt]]></reverseRegex><forwardRegex><![CDATA[actagt]]></forwardRegex><downstream><dsForward>1</dsForward><dsReverse>5</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>SphI</name><site>gcatgc</site><cutType>0</cutType><reverseRegex><![CDATA[gcatgc]]></reverseRegex><forwardRegex><![CDATA[gcatgc]]></forwardRegex><downstream><dsForward>5</dsForward><dsReverse>1</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>XbaI</name><site>tctaga</site><cutType>0</cutType><reverseRegex><![CDATA[tctaga]]></reverseRegex><forwardRegex><![CDATA[tctaga]]></forwardRegex><downstream><dsForward>1</dsForward><dsReverse>5</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>XhoI</name><site>ctcgag</site><cutType>0</cutType><reverseRegex><![CDATA[ctcgag]]></reverseRegex><forwardRegex><![CDATA[ctcgag]]></forwardRegex><downstream><dsForward>1</dsForward><dsReverse>5</dsReverse></downstream><upstream></upstream></enzyme><enzyme><name>XmaI</name><site>cccggg</site><cutType>0</cutType><reverseRegex><![CDATA[c{3}g{3}]]></reverseRegex><forwardRegex><![CDATA[c{3}g{3}]]></forwardRegex><downstream><dsForward>1</dsForward><dsReverse>5</dsReverse></downstream><upstream></upstream></enzyme></enzymes>;
			
			for each (var enzymeXML:XML in commonRestrictionEnzymesXML.enzyme) {
				var name:String = enzymeXML.name;
				var site:String = enzymeXML.site;
				
				var forwardRegex:String = enzymeXML.forwardRegex;
				forwardRegex = forwardRegex.toUpperCase();
				
				var reverseRegex:String = enzymeXML.reverseRegex;
				reverseRegex = reverseRegex.toUpperCase();
				
				var cutType:String = enzymeXML.cutType;
				
				var re:RestrictionEnzyme = new RestrictionEnzyme();
				re.name = name;
				re.site = site;
				re.cutType = "0" ? 0 : 1;
				re.forwardRegex = forwardRegex;
				re.reverseRegex = reverseRegex;
				
				if(enzymeXML.downstream != null) {
					re.dsForward = enzymeXML.downstream.dsForward
					re.dsReverse = enzymeXML.downstream.dsReverse;
				}
				
				if(enzymeXML.upstream != null) {
					re.usForward = enzymeXML.upstream.usForward
					re.usReverse = enzymeXML.upstream.usReverse;
				}
				
				enzymes.addItem(re);
			}
			
			return enzymes;		
		}
	}
}