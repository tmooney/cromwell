package cromwell.backend.google.pipelines.v1alpha2

import akka.actor.ActorRef
import cromwell.backend.BackendConfigurationDescriptor
import cromwell.backend.google.pipelines.common.{PipelinesApiBackendLifecycleActorFactory, PipelinesApiBackendSingletonActor, PipelinesApiConfiguration}
import cromwell.backend.google.pipelines.v1alpha2.api.request.RequestHandler

class PipelinesApiLifecycleFactory(name: String, configurationDescriptor: BackendConfigurationDescriptor)
  extends PipelinesApiBackendLifecycleActorFactory(name, configurationDescriptor) {
  private val genomicsFactory = GenomicsFactory(googleConfig.applicationName, jesAttributes.auths.genomics, jesAttributes.endpointUrl)
  override protected val jesConfiguration = PipelinesApiConfiguration(configurationDescriptor, genomicsFactory, googleConfig, jesAttributes)
  override def requiredBackendSingletonActor(serviceRegistryActor: ActorRef) = {
    implicit val batchHandler = new RequestHandler(googleConfig.applicationName)
    PipelinesApiBackendSingletonActor.props(jesConfiguration.qps, jesConfiguration.papiRequestWorkers, serviceRegistryActor)
  }
}