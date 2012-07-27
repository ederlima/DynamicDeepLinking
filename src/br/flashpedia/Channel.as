package br.flashpedia 
{
	import br.flashpedia.DynamicNavigation.core.*;
	import br.flashpedia.DynamicNavigation.data.*;
	import br.flashpedia.DynamicNavigation.events.*;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eder Lima
	 */
	public class Channel extends MovieClip
	{
		//Criando um objeto navigator
		private var navigator:DynamicNavigator;
		
		public function Channel() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//Utilizando a instância do navegador já criada no Index (Main.as)
			navigator = DynamicNavigator.getInstance();
			//Adicionando os dois ouvintes obrigatórios
			//Transição de entrada
			navigator.addEventListener(DynamicNavigatorEvent.TRANSITION_IN_START, transitionIn);
			//Transição de Saída
			navigator.addEventListener(DynamicNavigatorEvent.TRANSITION_OUT_START, transitionOut);
		}
		//Transição de entrada, executada ao fim do carregamento, assim que o filme é adicionado ao alvo
		//Deve obrigatoriamente, disparar o evento DynamicNavigatorEvent.TRANSITION_IN_COMPLETE ao final
		private function transitionIn(event:DynamicNavigatorEvent):void
		{
			TweenLite.to(f, 1, { alpha:1, ease:Strong.easeOut, onComplete:transitionInComplete } );
		}
		//Função, ao final da transição de entrada, que dispara o evento DynamicNavigatorEvent.TRANSITION_IN_COMPLETE
		private function transitionInComplete():void
		{
			navigator.dispatchEvent(new DynamicNavigatorEvent(DynamicNavigatorEvent.TRANSITION_IN_COMPLETE));
		}
		//Transição de saída, executada quando se troca o canal, 
		//Deve obrigatoriamente, disparar o evento DynamicNavigatorEvent.TRANSITION_OUT_COMPLETE ao final, 
		//Para informar ao navegador que pode fazer a chamada do próximo canal
		private function transitionOut(event:DynamicNavigatorEvent):void
		{
			TweenLite.to(f, 1, { alpha:0, ease:Strong.easeOut, onComplete:transitionOutComplete } );
		}
		//Função, ao final da transição de saída, que dispara o evento DynamicNavigatorEvent.TRANSITION_OUT_COMPLETE
		private function transitionOutComplete():void
		{
			navigator.dispatchEvent(new DynamicNavigatorEvent(DynamicNavigatorEvent.TRANSITION_OUT_COMPLETE));
		}
	}

}