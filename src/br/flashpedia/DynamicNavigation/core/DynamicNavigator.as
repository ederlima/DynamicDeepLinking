/*
	DynamicNavigator
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
package br.flashpedia.DynamicNavigation.core
{
	import br.flashpedia.DynamicNavigation.data.DynamicItem;
	import br.flashpedia.DynamicNavigation.data.DynamicNavigatorData;
	import br.flashpedia.DynamicNavigation.core.DynamicLoader;
	import br.flashpedia.DynamicNavigation.events.DynamicLoaderEvent;
	import br.flashpedia.DynamicNavigation.events.DynamicNavigatorEvent;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import SWFAddress;
	import SWFAddressEvent;
	/**
		<h2>DynamicNavigator : Singleton </h2>
		<p>Classe que controla todo o sistema de navegação por <a href="http://en.wikipedia.org/wiki/Deep_linking" title="Deeplinking na Wikipedia" target="_blank">DeepLinking </a>permitindo assim a navegação em níveis dentro do Flash.<br />
		  Esta Classe utiliza as Classes TopLevel SWFAddress e SWFAddressEvent, que você pode encontrar aqui: <a href="http://www.asual.com" title="Asual" target="_blank">http://www.asual.com</a>.</p>
	
	 <p><strong>Como funciona:</strong></p>
		<p>A DynamicNavigator funciona como uma lista de canais a serem controlados, esta lista de canais possui itens com informações padronizadas, cada item é um Objeto da Classe DynamicItem, a classe DynamicNavigator é responsável por controlar quais itens existem, quais foram ou não carregados e disparar eventos que informem a esses canais como funcionar.</p>
		<p><strong>Modo de uso:</strong></p>
		<p>Crie objetos <strong>DynamicItem</strong>, ex:</p>
		<p><blockquote>var item1:DynamicItem = new DynamicItem();<br />
		  item1.label = &quot;Item 1&quot;;<br />
		  item1.name = &quot;item1&quot;;<br />
		  item1.deeplink = &quot;/canal1/&quot;;<br />
		  item1.file = &quot;canal1.swf&quot;;</blockquote> </p>
		<p>Repita os passos para cada canal (você pode cirar itens a partir de um xml, ou de uma string Json)</p>
		<p>A classe <strong>DynamicNavigator</strong> é Singleton, só pode ser instanciada uma vez, então utilize <strong>obj.getInstance();</strong> ao invés de <strong>obj = new DynamicNavigator();</strong></p>
		<p><blockquote>var navigator:DynamicNavigator;<br />
		  navigator = DynamicNavigator.getInstance();</blockquote> </p>
		<p><strong>Adicione os itens a lista do DynanicNavigator:</strong></p>
		<p><blockquote>navigator.addItem(item1); //E assim por diante com todos, em seguida, inicie o navegador<br />
		  navigator.init(&quot;/canal1/&quot;, &quot;/404/&quot;);</blockquote></p>
		<p>Repare que foram utilizados dois canais como parâmetros para início do navegador, um para canal inicial e outro para canal de erro, desta forma:</p>
		<ul>
		  <li>Canal inicial: Será carregado por padrão, ao iniciar a classe, caso não haja deeplink configurado, ex: http://www.seusite.com/</li>
		  <li>Canal de erro: Será carregado caso, ao iniciar a classe ou navegar, o canal configurado no deeplink não exista na lista do navegador, ex: http://www.seusite.com/#/canal-invalido/</li>
		</ul>
		<p><strong>Para configurar o site para carregar o canal informado no deeplink ao navegar, ex: http://www.seusite.com/#/canal1/, adicione, antes de iniciar a classe:</strong></p>
		<p><blockquote>navigator.addEventListener(DynamicNavigatorEvent.CHANGE, onChangeFunction);<br />
		  function onChangeFunction(event:DynamicNavigatorEvent):void<br />
		  {<br />
		  navigator.navigateTo(event.navigatorData.anchorValue);<br />
		  } </blockquote></p>
		<p>Dessa forma, você pode enviar um link direto para uma pessoa, ex: http://www.seusite.com/#/canal1/ que ao carregar o navegador checará a existência desse item em sua lista e carregará corretamente o canal, ou informará o erro caso não exista.</p>
		<p><strong>Em síntese:</strong></p>
		<blockquote>
		<p>import br.flashpedia.DynamicNavigation.core.*;<br />
		  import br.flashpedia.DynamicNavigation.data.*;<br />
		  import br.flashpedia.DynamicNavigation.events.*;</p>
		<p> var navigator:DynamicNavigator;<br />
		  navigator = DynamicNavigator.getInstance();</p>
		<p>var item1:DynamicItem = new DynamicItem();<br />
		  item1.label = &quot;Item 1&quot;;<br />
		  item1.name = &quot;item1&quot;;<br />
		  item1.deeplink = &quot;/canal1/&quot;;<br />
		  item1.file = &quot;canal1.swf&quot;;</p>
		<p>navigator.addItem(item1);</p>
		<p>navigator.addEventListener(DynamicNavigatorEvent.CHANGE, onChange);</p>
		<p>navigator.init(&quot;/canalpadrao/&quot;, &quot;/canaldeerro/&quot;); </p>
		</blockquote>
		<p>Obviamente que você pode criar botões de menu e navegar através deles, basta anexar uma propriedade com valor do deeplink de um DynamicItem existente na lista do DynamicNavigator, ex:</p>
		<blockquote>
		<p>button1.deeplink = &quot;/canal1/&quot;;<br />
		  button1.addEventListener(MouseEvent.CLICK, navOnClick);<br />
		  function navOnClick(event:MouseEvent):void<br />
		  {<br />
		  navigator.navigateTo(event.target.deeplink); <br />
		  }</p>
		</blockquote>
		</body>
	 */
	public class DynamicNavigator extends EventDispatcher
	{
		private static var allowInstantiation:Boolean;
		private static var instance:DynamicNavigator = null;
		private var _siteName:String = "";
		private var _loader:DynamicLoader;
		private var _itens:Dictionary = new Dictionary();
		private var _loadedItens:Dictionary = new Dictionary();
		private var _defaultChannel:String = "";
		private var _errorChannel:String = "";
		private var _channelToLoad:String = "";
		private var _navigatorData:DynamicNavigatorData = new DynamicNavigatorData();
		private var _defaultTarget:MovieClip = null;
		/**
		 * Construtor da Classe: Singleton
		 * <br />Não pode ser instanciado
		 */
		public function DynamicNavigator() 
		{
			if (!allowInstantiation)
			{
				throw new Error("Esta classe não pode ser instanciada, use \"ref.getInstance()\" ao invés disso.");
			}
		}
		/**
		 * Usa o Singleton DynamicNavigator do ambiente ou cria uma instância para ser utilizada
		 * @return Objeto DynamicNavigator
		 */
		public static function getInstance():DynamicNavigator
		{
			if (instance == null)
			{
				allowInstantiation = true;
				instance = new DynamicNavigator();
				allowInstantiation = false;
			}
			return instance;
		}
		/**
		 * Inicia a execução do navegador
		 * @param	defaultChannel Canal padrão para início, ex: '/home/'
		 * @param	errorChannel Canal padrão para erro, ex: '/404/'
		 */
		public function init(defaultChannel:String, errorChannel:String):void
		{
			_loader = DynamicLoader.getInstance();
			_loader.addEventListener(DynamicLoaderEvent.LOAD_COMPLETE, onLoadComplete);
			_loader.addEventListener(DynamicLoaderEvent.LOAD_PROGRESS, onLoadProgress);
			_loader.addEventListener(DynamicLoaderEvent.LOAD_START, onLoadStart);
			_loader.addEventListener(DynamicLoaderEvent.LOAD_ERROR, onLoadError);
			_defaultChannel = defaultChannel;
			_errorChannel = errorChannel;
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, dispatchChange);
			addEventListener(DynamicNavigatorEvent.TRANSITION_OUT_COMPLETE, transitionOutComplete);
		}
		/**
		 * Adiciona itens ao navegador, para que seja criada uma lista de canais
		 * @param	deepLink Endereço do link para o item especificado, ex: "/canal/"
		 * @param	menuItem Objeto menuItem, contém as informações do filme a ser carregado, ex: url, nome, rótulo, deeplink
		 */
		public function addItem(menuItem:DynamicItem):void
		{
			_itens[menuItem.deeplink] = menuItem;
		}
		/**
		 * Navega para um novo canal, ex: '/canal/'.
		 * É a forma padrão de navegação do sistema
		 * @param	channel Canal para navegação, deve constar em um dos itens da lista do DynamicNavigator, ex: '/canal/'
		 */
		public function navigateTo(channel:String):void
		{
			if (channel == "/" || channel == "")
			{
				_channelToLoad = _itens[_defaultChannel].file;
				channel = _itens[_defaultChannel].deeplink;
			}
			else if(_itens[channel] == undefined)
			{
				_channelToLoad = _itens[_errorChannel].file;
				channel = _itens[_errorChannel].deeplink;
			}
			else
			{
				_channelToLoad = _itens[channel].file;
			}
			SWFAddress.setValue(channel);
			SWFAddress.setTitle(_siteName + " | " + _itens[channel].label);
		}
		private function dispatchChange(event:SWFAddressEvent):void
		{
			_navigatorData.anchorValue = event.value;
			dispatchEvent(new DynamicNavigatorEvent(DynamicNavigatorEvent.CHANGE, _navigatorData));
			callChannel();
		}
		private function callChannel():void
		{
			if (_defaultTarget.numChildren > 0)
			{
				dispatchEvent(new DynamicNavigatorEvent(DynamicNavigatorEvent.TRANSITION_OUT_START));
			}
			else
			{
				loadChannel();
			}
		}
		private function loadChannel():void
		{
			if (_loadedItens[_channelToLoad] == undefined)
			{
				dispatchEvent(new DynamicNavigatorEvent(DynamicNavigatorEvent.LOAD_START));
				_loader.loadContent(_channelToLoad);
			}
			else
			{
				addChannel();
			}
		}
		private function addChannel():void
		{
			_defaultTarget.removeChildAt(0);
			_defaultTarget.addChild(_loadedItens[_channelToLoad]);
			dispatchEvent(new DynamicNavigatorEvent(DynamicNavigatorEvent.TRANSITION_IN_START));
		}
		private function transitionOutComplete(event:DynamicNavigatorEvent):void
		{
			loadChannel();
		}
		private function onLoadComplete(event:DynamicLoaderEvent):void
		{
			dispatchEvent(new DynamicNavigatorEvent(DynamicNavigatorEvent.LOAD_COMPLETE, _navigatorData));
			_loadedItens[_channelToLoad] = event.loaderData.content;
			_defaultTarget.numChildren > 0 ? _defaultTarget.removeChildAt(0) : void;
			_defaultTarget.addChild(event.loaderData.content);
			dispatchEvent(new DynamicNavigatorEvent(DynamicNavigatorEvent.TRANSITION_IN_START));
		}
		private function onLoadProgress(event:DynamicLoaderEvent):void
		{
			_navigatorData.bytesLoaded = event.loaderData.loadedBytes;
			_navigatorData.bytesTotal = event.loaderData.totalBytes;
			dispatchEvent(new DynamicNavigatorEvent(DynamicNavigatorEvent.LOAD_PROGRESS, _navigatorData));
		}
		private function onLoadStart(event:DynamicLoaderEvent):void
		{			
			dispatchEvent(new DynamicNavigatorEvent(DynamicNavigatorEvent.LOAD_START, _navigatorData));
		}
		private function onLoadError(event:DynamicLoaderEvent):void
		{
			
		}
		/**
		 * Dictionary contendo os itens
		 */
		public function get itens():Dictionary
		{
			return _itens;
		}
		public function set itens(value:Dictionary):void
		{
			_itens = value;
		}
		/**
		 * Alvo padrão para todos os canais
		 * <br />MovieClip que serve de container para todos os canais
		 */
		public function get defaultTarget():MovieClip
		{
			return _defaultTarget;
		}
		public function set defaultTarget(value:MovieClip):void
		{
			_defaultTarget = value;
		}
		/**
		 * Nome padrão do Site na barra de título do navegador
		 */
		public function get siteTitle():String
		{
			return _siteName;
		}
		public function set siteTitle(value:String):void
		{
			_siteName = value;
		}
		/**
		 * Dictionary com itens já carregados
		 */
		public function get loadedItens():Dictionary
		{
			return _loadedItens;
		}
		
	}

}