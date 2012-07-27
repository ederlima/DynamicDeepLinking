/*
	DynamicLoaderEvent
    Copyright (C) <2010>  <FlashPedia.com.br>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
package br.flashpedia.DynamicNavigation.events
{
	import br.flashpedia.DynamicNavigation.data.DynamicLoaderData;
	import flash.events.Event;
	
	/**
	 * DynamicLoaderEvent Dispara eventos da Classe DynamicLoader
	 * @author Eder Lima
	 */
	public class DynamicLoaderEvent extends Event 
	{ 
		private var _loaderData:DynamicLoaderData = new DynamicLoaderData();
		/**
		 * Disparado quando o carregamento de um novo filme inicia
		 */
		public static const LOAD_START:String = "loadStart";
		/**
		 * Disparado durante o progresso do carregamento
		 */
		public static const LOAD_PROGRESS:String = "loadProgress";
		/**
		 * Disparado ao término do carregamento
		 */
		public static const LOAD_COMPLETE:String = "loadComplete";
		/**
		 * Disparado se houver erro no carregamento
		 */
		public static const LOAD_ERROR:String = "loadError";
		
		public function DynamicLoaderEvent(type:String, loaderData:DynamicLoaderData = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			this._loaderData = loaderData;
			super(type, bubbles, cancelable);
		} 
		public override function clone():Event 
		{ 
			return new DynamicLoaderEvent(type, loaderData, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("DynamicLoaderEvent", "DynamicLoaderData", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		/**
		 * Objeto DynamicLoaderData, conserva informações básicas sobre o arquivo carregado
		 */
		public function get loaderData():DynamicLoaderData
		{
			return _loaderData;
		}
	}
	
}