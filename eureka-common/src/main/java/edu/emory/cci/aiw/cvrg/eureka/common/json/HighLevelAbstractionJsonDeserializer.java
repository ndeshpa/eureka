/*
 * #%L
 * Eureka Common
 * %%
 * Copyright (C) 2012 - 2013 Emory University
 * %%
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * #L%
 */
package edu.emory.cci.aiw.cvrg.eureka.common.json;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.JsonParser;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.JsonToken;
import org.codehaus.jackson.map.DeserializationContext;
import org.codehaus.jackson.map.JsonDeserializer;
import org.codehaus.jackson.map.JsonMappingException;
import org.protempa.ExtendedPropositionDefinition;
import org.protempa.GapFunction;
import org.protempa.HighLevelAbstractionDefinition;
import org.protempa.proposition.interval.Interval.Side;
import org.protempa.PropertyDefinition;
import org.protempa.ReferenceDefinition;
import org.protempa.SimpleGapFunction;
import org.protempa.SourceId;
import org.protempa.TemporalExtendedPropositionDefinition;
import org.protempa.TemporalPatternOffset;
import org.protempa.proposition.interval.Relation;
import org.protempa.proposition.value.Unit;
import org.protempa.proposition.value.Value;

public final class HighLevelAbstractionJsonDeserializer extends
        JsonDeserializer<HighLevelAbstractionDefinition> {

	private JsonParser parser;

	@Override
	public HighLevelAbstractionDefinition deserialize(JsonParser jp,
	        DeserializationContext ctxt) throws IOException,
	        JsonProcessingException {
		this.parser = jp;
		
		if (this.parser.getCurrentToken() == JsonToken.START_OBJECT) {
			nextToken(); // should be the id field
		}

		checkField("id");
		
		// now we can construct the HLA
		HighLevelAbstractionDefinition value = new HighLevelAbstractionDefinition(
		        this.parser.readValueAs(String.class));
		value.setInDataSource(false);
		value.setSolid(true);
		value.setConcatenable(true);
		value.setGapFunction(new SimpleGapFunction());
		nextToken();
		checkField("displayName");
		value.setDisplayName(this.parser.readValueAs(String.class));
		nextToken();
		checkField("abbreviatedDisplayName");
		value.setAbbreviatedDisplayName(this.parser.readValueAs(String.class));
		nextToken();
		checkField("description");
		value.setDescription(this.parser.readValueAs(String.class));
		
		nextToken();
		checkField("inverseIsA");
		value.setInverseIsA(this.parser.readValueAs(String[].class));
		
		nextToken();
		checkField("properties");
		value.setPropertyDefinitions(this.parser.readValueAs(PropertyDefinition[].class));
		
		nextToken();
		checkField("references");
		value.setReferenceDefinitions(this.parser.readValueAs(ReferenceDefinition[].class));
		
		nextToken();
		checkField("solid");
		value.setSolid(this.parser.getBooleanValue());
		
		nextToken();
		checkField("concatenable");
		value.setConcatenable(this.parser.getBooleanValue());
		
		nextToken();
		checkField("inDataSource");
		value.setInDataSource(this.parser.getBooleanValue());
		
		nextToken();
		checkField("sourceId");
		SourceId sourceId = this.parser.readValueAs(SourceId.class);
		value.setSourceId(sourceId);
		
		nextToken();
		checkField("gapFunction");
		value.setGapFunction(this.parser.readValueAs(GapFunction.class));
		
		nextToken();
		checkField("extendedPropositions");
		nextToken();
		int i = 1;
		Map<Long, ExtendedPropositionDefinition> indices =
				new HashMap<Long, ExtendedPropositionDefinition>();
		while (parser.getCurrentToken() != JsonToken.END_OBJECT) {
			checkField("" + i);
			TemporalExtendedPropositionDefinition ep = this.parser
			        .readValueAs(TemporalExtendedPropositionDefinition.class);
			value.add(ep);
			indices.put(Long.valueOf(i), ep);
			nextToken();
			i++;
		}
		
		nextToken();
		checkField("relations");
		nextToken();
		while (parser.getCurrentToken() != JsonToken.END_OBJECT) {
			checkField("lhs");
			ExtendedPropositionDefinition lhs = 
					indices.get(Long.valueOf(this.parser.getLongValue()));
			if (!(lhs instanceof TemporalExtendedPropositionDefinition)) {
				throw new JsonMappingException("Proposition definition " 
						+ lhs.getPropositionId() 
						+ " is not temporal and cannot be in a temporal relation");
			}
			nextToken();
			checkField("rhs");
			ExtendedPropositionDefinition rhs =
					indices.get(Long.valueOf(this.parser.getLongValue()));
			if (!(rhs instanceof TemporalExtendedPropositionDefinition)) {
				throw new JsonMappingException("Proposition definition " 
						+ rhs.getPropositionId() 
						+ " is not temporal and cannot be in a temporal relation");
			}
			nextToken();
			checkField("relation");
			Relation rel = this.parser.readValueAs(Relation.class);
			value.setRelation((TemporalExtendedPropositionDefinition) lhs, 
					(TemporalExtendedPropositionDefinition) rhs, rel);
			nextToken();
		}
		nextToken();
		
		checkField("temporalOffset");
		nextToken();
		if (parser.getCurrentToken() != JsonToken.END_OBJECT) {
			TemporalPatternOffset offsets = new TemporalPatternOffset();
			checkField("startExtendedProposition");
			Long startIndex = this.parser.getLongValue();
			if (startIndex != null) {
				ExtendedPropositionDefinition start = indices.get(startIndex);
				if (!(start instanceof TemporalExtendedPropositionDefinition)) {
					throw new JsonMappingException("Proposition definition " 
						+ start.getPropositionId() 
						+ " is not temporal and cannot be in a temporal relation");
				}
				offsets.setStartTemporalExtendedPropositionDefinition((TemporalExtendedPropositionDefinition) start);
			}
			nextToken();
			checkField("startValue");
			offsets.setStartAbstractParamValue(this.parser.readValueAs(Value.class));
			nextToken();
			checkField("startSide");
			offsets.setStartIntervalSide(this.parser.readValueAs(Side.class));
			nextToken();
			checkField("startOffset");
			offsets.setStartOffset(this.parser.getIntValue());
			nextToken();
			checkField("startOffsetUnits");
			offsets.setStartOffsetUnits(this.parser.readValueAs(Unit.class));
			nextToken();
			checkField("finishExtendedProposition");
			Long finishIndex = this.parser.getLongValue();
			if (finishIndex != null) {
				ExtendedPropositionDefinition finish = indices.get(finishIndex);
				if (!(finish instanceof TemporalExtendedPropositionDefinition)) {
					throw new JsonMappingException("Proposition definition " 
						+ finish.getPropositionId() 
						+ " is not temporal and cannot be in a temporal relation");
				}
				offsets.setFinishTemporalExtendedPropositionDefinition((TemporalExtendedPropositionDefinition) finish);
			}
			nextToken();
			checkField("finishValue");
			offsets.setFinishAbstractParamValue(this.parser.readValueAs(Value.class));
			nextToken();
			checkField("finishSide");
			offsets.setFinishIntervalSide(this.parser.readValueAs(Side.class));
			nextToken();
			checkField("finishOffset");
			offsets.setFinishOffset(this.parser.getIntValue());
			nextToken();
			checkField("finishOffsetUnits");
			offsets.setFinishOffsetUnits(this.parser.readValueAs(Unit.class));
			
			nextToken();
			
			value.setTemporalOffset(offsets);
			
		}
		
		nextToken();
				
		return value;
	}

	private void checkField(String field) throws JsonParseException,
	        IOException {
		if (!(this.parser.getCurrentToken() == JsonToken.FIELD_NAME && field
		        .equals(this.parser.getCurrentName()))) {
			fail(field);
		} else {
			nextValue();
		}
	}

	private void nextToken() throws JsonParseException, IOException {
		this.parser.nextToken();
	}

	private void nextValue() throws JsonParseException, IOException {
		this.parser.nextValue();
	}

	private void fail(String property) throws JsonProcessingException {
		throw new JsonParseException(property
		        + " not found in expected location",
		        this.parser.getCurrentLocation());
	}
}
