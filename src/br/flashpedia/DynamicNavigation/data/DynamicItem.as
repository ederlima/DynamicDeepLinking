/*
	DynamicItem
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
	 * 
		<h2>DynamicItem: Objeto</h2>
		<p>A Classe <strong>DynamicItem</strong> é um objeto obrigatório para a Classe <strong>DynamicNavigator</strong>, responsável por referenciar cada canal da navegação através de suas propriedades:</p>
		<ul>
		  <li>label : Rótulo para o item, exemplo: &quot;Nome do canal&quot;</li>
		  <li>name: Referência para o item, exemplo: &quot;nomedocanal&quot;</li>
		  <li>deeplink: Link para o item, exemplo: &quot;/canal/&quot;</li>
		  <li>file: Arquivo do canal, ex: &quot;canal.swf&quot;</li>
		</ul>
		<p><strong>Essas 4 propriedades de cada item são necessárias para que se crie menus de navegação independentes e para que o DynamicNavigator possa organizar a navegação, sabendo qual canal está ou não pré-carregado e qual arquivo carregar para cada link.</strong></p>
	*/

	public class DynamicItem extends Object
	{
		private var _label:String;
		private var _deeplink:String;
		private var _file:String;
		private var _name:String;
		/**
		 * Cria um novo objeto DynamicItem
		 * @param	name Nome para o item, amigável, ex: 'canal'
		 * @param	label Rótulo para o item, livre, ex: 'Nome do Canal'
		 * @param	deeplink Deeplink para o canal, ex: '/canal/'
		 * @param	file Arquivo do canal, ex: 'canal.swf'
		 */
		public function DynamicItem(name:String, label:String, deeplink:String, swffile:String) 
		{
			_name = name;
			_label = label;
			_deeplink = deeplink;
			_file = swffile;
		}
		/**
		 * Rótulo para o item de menu, ex: "Canal Nome"
		 */
		public function get label():String
		{
			return _label;
		}
		public function set label(value:String):void
		{
			_label = value;
		}
		/**
		 * Deeplink para o item de menu, ex: "/canal/"
		 */
		public function get deeplink():String
		{
			return _deeplink;
		}
		public function set deeplink(value:String):void
		{
			_deeplink = value;
		}
		/**
		 * Arquivo para ser carregado por cada item do menu, ex: "canal.swf"
		 */
		public function get file():String
		{
			return _file;
		}
		public function set file(value:String):void
		{
			_file = value;
		}
		/**
		 * Nome da referência do item de menu, amigável e sem caraceteres especiais, ex: "canal"
		 */
		public function get name():String
		{
			return _name;
		}
		public function set name(value:String):void
		{
			_name = value;
		}
		
	}

}