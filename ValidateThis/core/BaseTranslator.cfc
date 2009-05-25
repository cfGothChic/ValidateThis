<!---
	
	Copyright 2009, Bob Silverberg
	
	Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in 
	compliance with the License.  You may obtain a copy of the License at 
	
		http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software distributed under the License is 
	distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or 
	implied.  See the License for the specific language governing permissions and limitations under the 
	License.
	
--->
<cfcomponent output="false" name="Translator" hint="I am a responsible for translating text.">

	<cffunction name="init" returnType="any" access="public" output="false" hint="I build a new Translator">
		<cfargument name="TransientFactory" type="any" required="true" />
		<cfargument name="ValidateThisConfig" type="any" required="true" />

		<cfset variables.TransientFactory = arguments.TransientFactory />
		<cfset variables.ValidateThisConfig = arguments.ValidateThisConfig />
		<cfset variables.instance.locales = loadLocales(arguments.ValidateThisConfig.localeMap) />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="translate" returnType="any" access="public" output="false" hint="I translate text">
		<cfargument name="translateThis" type="Any" required="true" />
		<cfargument name="locale" type="Any" required="false" default="" />
		<cfreturn arguments.translateThis />
	</cffunction>
	
	<cffunction name="loadLocales" returnType="any" access="public" output="false" hint="I return a struct of locale info">
		<cfargument name="localeMap" type="Any" required="true" />
		<cfreturn StructNew() />
	</cffunction>

	<cffunction name="getLocales" returnType="any" access="public" output="false" hint="I return the cached locales">
		<cfreturn variables.instance.locales />
	</cffunction>

</cfcomponent>
	
