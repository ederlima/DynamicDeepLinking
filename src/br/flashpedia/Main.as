package br.flashpedia
{
	//Importando as classes do pacote necessárias para a MainClass
	import br.flashpedia.DynamicNavigation.core.DynamicNavigator;
	import br.flashpedia.DynamicNavigation.events.DynamicNavigatorEvent;
	import br.flashpedia.DynamicNavigation.data.DynamicItem;
	import br.flashpedia.DynamicNavigation.data.DynamicNavigatorData;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	
	/**
	 * Document Class de exemplo para o pacote DynamicNavigation
	 * @author Eder Lima
	 */
	public class Main extends MovieClip 
	{
		//criando a referência para o DynamicNavigator
		private var navigator:DynamicNavigator;
		public function Main():void 
		{
			if (stage) init();
			//Iniciando o filme
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//Utilizando (ou criando) a instância da Classe DynamicNavigator (Singleton)
			navigator = DynamicNavigator.getInstance();	
			//Executando a função que cria o menu e configura o navegador
			configureMenu();	
			//escondendo o loader
			info.visible = false;
		}
		private function configureMenu():void
		{
			for (var i:int = 0; i < 4; i++)
			{
				/*
				 * Criando 4 DynamicItens, que serão os canais do site
				 * Já existem 4 filmes com os nomes de canal0.swf, canal1.swf, etc
				 * Então basicamente uso o loop para criar os itens de acordo com isso
				*/
				var item:DynamicItem = new DynamicItem("canal" + i, "Canal " + i, "/canal-" + i + "/", "canal" + i + ".swf");
				//Adicionando cada DynamicItem craido a lista do navegador
				navigator.addItem(item);
				//Criando os botões de um menu, note que posso criar em processo separados dos DynamicItens
				var menu:MovieClip = new MyButton();
				//Rótulos para os menus, note a utilidade da propriedade "label" de cada DynamicItem
				menu.label.text = item.label;
				//Anexando uma propriedade comum para todos os botões, no caso, o deeplink, utilizando a propriedade deeplink
				//de cada DynamicItem (/canal-0/, /canal-1/, etc)
				menu.deeplink = item.deeplink;
				//Opções do Mouse
				menu.label.mouseEnabled = false;
				menu.buttonMode = true;
				//Posicionando os menus
				menu.y = 45;
				menu.x = 270 + ( i * (menu.width + 10));
				//Adicionando cada item de menu
				addChild(menu);
				//Adicionando o evento ao clicar sobre cada menu 
				//(utilizará a propriedade deeplink, comum a todos, para navegar entre os canais)
				menu.addEventListener(MouseEvent.CLICK, navigateOnClick);
			}
			//Adicionando o ouvinte para as mudanças na url para o navegador
			navigator.addEventListener(DynamicNavigatorEvent.CHANGE, onChange);
			//Mostrando o loader ao carregar
			navigator.addEventListener(DynamicNavigatorEvent.LOAD_START, showLoader);
			//Escondendo ao terminar
			navigator.addEventListener(DynamicNavigatorEvent.LOAD_COMPLETE, hideLoader);
			//Informando o percentual
			navigator.addEventListener(DynamicNavigatorEvent.LOAD_PROGRESS, showProgress);
			//Configurando o alvo padrão (MovieClip) do navegador, onde serão carregados ou mostrados os filmes
			//Existe um filme instanciado como "t" no palco do filme principal
			navigator.defaultTarget = t;
			//Configurando um nome padrão para o site
			navigator.siteTitle = "FlashPedia DeepLinking";
			//Iniciando o navegador e configurando os canais padrão e de erro
			//Leia a documentação sobre esses dois parâmetros
			navigator.init("/canal-0/", "/canal-0/");
		}
		//Função que responde ao clique sobre cada botão, utilizando a propriedade deeplink contida
		//em cada botão para navegar, utilizando a função navigateTo do navegador
		private function navigateOnClick(event:MouseEvent):void
		{
			navigator.navigateTo(event.target.deeplink);
		}
		//Função que responde as alterações na url (barra de endereços do navegador, histórico, etc)
		//Navega utilizando a mesma função navigateTo do navegador
		private function onChange(event:DynamicNavigatorEvent):void
		{
			navigator.navigateTo(event.navigatorData.anchorValue);
		}
		//Mostrando o loader
		private function showLoader(event:DynamicNavigatorEvent):void
		{
			info.visible = true;
		}
		//Escondento o loader
		private function hideLoader(event:DynamicNavigatorEvent):void
		{
			info.visible = false;
			info.text = "carregando...";
		}
		//Mostrando o progresso
		private function showProgress(event:DynamicNavigatorEvent):void
		{
			info.text = String("carregando... " + int(event.navigatorData.bytesLoaded/event.navigatorData.bytesTotal*100) + "%");
		}
	}
	
}