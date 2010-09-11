<!---
	
	Copyright 2010, Adam Drew
	
	Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in 
	compliance with the License.  You may obtain a copy of the License at 
	
		http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software distributed under the License is 
	distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or 
	implied.  See the License for the specific language governing permissions and limitations under the 
	License.
	
--->
<cfcomponent output="false" extends="AbstractServerRuleValidator" hint="I am responsible for performing the IsValidObject validation.">

	<cffunction name="validate" returntype="any" access="public" output="false" hint="I perform the validation returning info in the validation object.">
		<cfargument name="validation" type="any" required="yes" hint="The validation object created by the business object being validated." />

		<cfset var Parameters = arguments.validation.getParameters() />
		<cfset var theVal = arguments.validation.getObjectValue()/>
		<cfset var context = arguments.validation.getParameterValue("context","*")/>
		<cfset var toCheck = []/>
		<cfset var theObject = 0/>
		<cfset var theResult = arguments.validation.getValidateThis().newResult()/>
		
		<cfif not shouldTest(arguments.validation)><cfreturn/></cfif>

		<cfif isSimpleValue(theVal)> 
			<!--- Maybe this is a JSON string? Can this Handle the case? --->
			<cfif isJSON(theVal)>
				<cfset theVal = deserializeJSON(theVal)/>
			<cfelse>
				<cfset fail(arguments.validation,createDefaultFailureMessage("validation failed because a valid object cannot be a simple value.")) />
				<cfreturn/>
			</cfif>
		</cfif> 
				
		<cfif isStruct(theVal) and (not isObject(theVal) and structCount(theVal) eq 0)>
			<cfset fail(arguments.validation,createDefaultFailureMessage("validation failed because a valid structure cannot be empty.")) />
			<cfreturn/>
		</cfif>
		
		<cfif  isArray(theVal) and arrayLen(theVal) eq 0>
			<cfset fail(arguments.validation,createDefaultFailureMessage("validation failed because a valid array cannot be empty.")) />
			<cfreturn/>
		<cfelseif isArray(theVal)>
			<cfset toCheck = theVal/>
		<cfelse>
			<cfset arrayAppend(toCheck,theVal)/>
		</cfif>
		
		<cfloop array="#toCheck#" index="theObject">
			<!--- Now Lets Actually Try TO Validate This Apparent Objects --->
			<cfset theResult = arguments.validation.getValidateThis().validate(theObject=theObject,context=context,theResult=theResult)/>
			<cfif not theResult.getIsSuccess()>
				<cfset fail(arguments.validation,createDefaultFailureMessage("#arguments.validation.getPropertyDesc()# is invalid: #theResult.getFailuresAsString()#")) />
			</cfif>
		</cfloop>
		
	</cffunction>
	
</cfcomponent>