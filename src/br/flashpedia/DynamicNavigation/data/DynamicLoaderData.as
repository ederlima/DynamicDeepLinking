/*
	DynamicLoaderData
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
	import flash.display.MovieClip;
	/**
	 * DynamicLoaderData Objeto com informações do DynamicLoader
	 * @author Eder Lima
	 */
	public class DynamicLoaderData extends Object
	{
		private var _content:MovieClip = null;
		private var _loadedBytes:Number = 0;
		private var _totalBytes:Number = 0;
		private var _error:String;
		
		public function DynamicLoaderData() 
		{
			
		}
		/**
		 * Objeto carregado:MovieClip
		 */
		public function get content():MovieClip
		{
			return _content;
		}
		public function set content(value:MovieClip):void
		{
			_content = value;
		}
		/**
		 * Bytes carregados
		 */
		public function get loadedBytes():Number
		{
			return _loadedBytes;
		}
		public function set loadedBytes(value:Number):void
		{
			_loadedBytes = value;
		}
		/**
		 * Total de bytes do arquivo
		 */
		public function get totalBytes():Number
		{
			return _totalBytes;
		}
		public function set totalBytes(value:Number):void
		{
			_totalBytes = value;
		}
		/**
		 * Mensagem de erro
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