/*
	DynamicLoader
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
	import br.flashpedia.DynamicNavigation.data.DynamicLoaderData;
	import br.flashpedia.DynamicNavigation.events.DynamicLoaderEvent;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	/**
	 * DynamicLoader: SINGLETON
	 * @author Eder Lima
	 */
	public class DynamicLoader extends EventDispatcher
	{
		private var _loader:Loader = new Loader();
		private var _loaderData:DynamicLoaderData = new DynamicLoaderData();
		private static var allowInstantiation:Boolean;
		private static var instance:DynamicLoader = null;
		/**
		 * Utiliza o objeto DynamicLoader no ambiente ou cria o objeto
		 * @return Objeto DynamicLoader
		 */
		public static function getInstance():DynamicLoader
		{
			if (instance == null)
			{
				allowInstantiation = true;
				instance = new DynamicLoader();
				allowInstantiation = false;
			}
			return instance;
		}
		/**
		 * Construtor da Classe: Singleton
		 * <br />Não pode ser instanciado
		 */
		public function DynamicLoader() 
		{
			if (!allowInstantiation)
			{
				throw new Error("Esta classe não pode ser instanciada, use \"ref.getInstance()\" ao invés disso.");
			}
			else
			{
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
				_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoaderProgress);
				_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
			}
		}
		/**
		 * Carrega o filme
		 * @param	contentURL Endereço do filme, ex: "filme.swf"
		 */
		public function loadContent(contentURL:String):void
		{
			dispatchEvent(new DynamicLoaderEvent(DynamicLoaderEvent.LOAD_START));
			_loader.unload();
			_loader.load(new URLRequest(contentURL));
		}
		private function onLoaderComplete(event:Event):void
		{
			_loaderData.content = event.target.content as MovieClip;
			dispatchEvent(new DynamicLoaderEvent(DynamicLoaderEvent.LOAD_COMPLETE, _loaderData));
		}
		private function onLoaderProgress(event:ProgressEvent):void
		{
			_loaderData.loadedBytes = event.bytesLoaded;
			_loaderData.totalBytes = event.bytesTotal;
			dispatchEvent(new DynamicLoaderEvent(DynamicLoaderEvent.LOAD_PROGRESS, _loaderData));
		}
		private function onLoaderError(event:IOErrorEvent):void
		{
			_loaderData.error = event.toString();
			dispatchEvent(new DynamicLoaderEvent(DynamicLoaderEvent.LOAD_ERROR, _loaderData));
		}
		
	}

}