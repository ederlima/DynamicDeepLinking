/*
	DynamicNavigatorData
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
package br.flashpedia.DynamicNavigation.data 
{
	/**
	 * DynamicNavigatorData Contém informações da Classe DynamicNavigator
	 * @author Eder Lima
	 */
	public class DynamicNavigatorData extends Object
	{
		private var _anchorValue:String = "";
		private var _bytesLoaded:Number = 0;
		private var _bytesTotal:Number = 0;
		private var _error:String = "";
		public function DynamicNavigatorData() 
		{
			
		}
		/**
		 * Caminho da âncora (#/canal/), ex: "/canal/"
		 */
		public function get anchorValue():String
		{
			return _anchorValue;
		}
		public function set anchorValue(value:String):void
		{
			_anchorValue = value;
		}
		/**
		 * Bytes carregados pelo DynamicLoader de um novo canal
		 */
		public function get bytesLoaded():Number
		{
			return _bytesLoaded;
		}
		public function set bytesLoaded(value:Number):void
		{
			_bytesLoaded = value;
		}
		/**
		 * Total em bytes de um novo canal
		 */
		public function get bytesTotal():Number
		{
			return _bytesTotal;
		}
		public function set bytesTotal(value:Number):void
		{
			_bytesTotal = value;
		}
		/**
		 * Mensagem de erro em caso de falha no Loader
		 */
		public function get error():String
		{
			return _error;
		}
		public function set error(value:String):void
		{
			_error = value;
		}
		
	}

}