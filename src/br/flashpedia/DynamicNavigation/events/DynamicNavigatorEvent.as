/*
	DynamicNavigatorEvent
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
	import br.flashpedia.DynamicNavigation.data.DynamicNavigatorData;
	import flash.events.Event;
	
	/**
	 * DynamicNavigatorEvent Dispara eventos da Classe DynamicNavigator
	 * @author Eder Lima
	 */
	public class DynamicNavigatorEvent extends Event 
	{
		private var _data:DynamicNavigatorData = new DynamicNavigatorData(); 
		/**
		 * Disparado para iniciar a transição de entrada de um canal carregado
		 */
		public static const TRANSITION_IN_START:String = "navigatorTransitionInStart";
		/**
		 * Disparado para informar que a transição de entrada de um canal foi finalizada
		 */
		public static const TRANSITION_IN_COMPLETE:String = "navigatorTransitionInComplete";
		/**
		 * Disparado para iniciar a transição de saída do canal exibido
		 */
		public static const TRANSITION_OUT_START:String = "navigatorTransitionOutStart";
		/**
		 * Dispara para informar que a transição de saída do canal exibido foi finalizada
		 */
		public static const TRANSITION_OUT_COMPLETE:String = "navigatorTransitionOutComplete";
		/**
		 * Disparado no início do carregamento de um novo canal
		 */
		public static const LOAD_START:String = "navigatorLoadStart";
		/**
		 * Disparado ao término do carregamento de um novo canal
		 */
		public static const LOAD_COMPLETE:String = "navigatorLoadComplete";
		/**
		 * Disparado durante todo o carregamento de um novo canal
		 */
		public static const LOAD_PROGRESS:String = "navigatorLoadProgress";
		/**
		 * Disparado ao abrir o filme e ao mudar o url na barra de endereços
		 */
		public static const CHANGE:String = "navigatorChange";
		
		public function DynamicNavigatorEvent(type:String, navigatorData:DynamicNavigatorData = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_data = navigatorData;
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new DynamicNavigatorEvent(type, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("DynamicNavigatorEvent", "DynamicNavigatorData", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		/**
		 * Contém informações do navegador
		 */
		public function get navigatorData():DynamicNavigatorData
		{
			return _data;
		}
		
	}
	
}